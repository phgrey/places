#require 'nokogiri'



class Parse::Mapia < Parsetask

  class Decoder

    def self.refine_interval(interval,cd,mask)
      if(cd&mask > 0)
        interval[0]=(interval[0]+interval[1])/2;
      else
        interval[1]=(interval[0]+interval[1])/2;
      end
    end

    def self.decodeGeoHash(geohash)
        lat=[-90.0, 90.0];
        lon=[-180.0, 180.0];
        geohash.split('').each_with_index {|c,i|
          cd = "0123456789bcdefghjkmnpqrstuvwxyz".index(c);
          for j in 0..4
            refine_interval((i+j) % 2 > 0 ? lat : lon, cd, 2 ** (4-j));
          end
        }

        {:latitude=>(lat[0]+lat[1])/2,:longitude=>(lon[0]+lon[1])/2}
    end
  end

  def self.source_name
    'mapia'
  end

  def self.available_locales
    [:ru, :en, :ua]
  end


  def get_child_type
    return City if parent.nil?
    return Category if (item_type == 'City') || (parent.item_type == 'City')
    return Place if (item_type == 'Category') && (parent.item_type == 'Category')
  end


  def all_urls
    {
        :city_by_main => 'http://mapia.ua/LANG/kiev',
        :category_by_city => 'http://mapia.ua/LANG/CITY_ID/index',
        :category_by_category => 'http://mapia.ua/LANG/CITY_ID/CATEGORY_ID',
        :place_by_category => 'http://mapia.ua/LANG/CITY_ID/CATEGORY_ID?page=PAGE_NR'
    }
  end

  def parse_city_by_main responce
    Nokogiri::HTML(responce).css('ul#city_list li a').map do |link|
      #get 'vinn-itsa' from '/ru/vinn-itsa/remember_city?return=%2Fru%2Fvinnitsa'
      ext_ids = { 'city_id' => link.attr('href').scan(/(?:ru|en|ua)\/([a-z-]*)/)[0][0]}
      {
          :external_ids => ext_ids,
          :title =>  link.content(),
          :path => ext_ids['city_id']
      }
    end
  end

  def parse_category_by_city responce
    Nokogiri::HTML(responce).css('div.all-categories h3 a:first-child').map do |link|
      ext_ids = {
          #get 'auto' from '/ru/vinnitsa/auto'
          'category_id' => link.attr('href').scan(/(?:ru|en|ua)\/(?:[a-z-]*)\/([a-z-]*)/)[0][0],
          'city_id' => external_ids['city_id']
      }
      {
          :external_ids => ext_ids,
          :title =>  link.content(),
          :path =>  ext_ids['category_id']
      }
    end
  end

  def parse_category_by_category responce
    Nokogiri::HTML(responce).css('div.see-also-subcategories ul li a').map do |link|
      ext_ids = {
          #get 'trests' from '/ru/vinnitsa/auto/trests'
          'category_id' => link.attr('href').scan(/(?:ru|en|ua)\/(?:[a-z-]*)\/([a-z-]*)/)[0][0],
          'city_id' => external_ids['city_id'],
          'page_nr' => '1'
      }
      {
          :external_ids => ext_ids,
          :title =>  link.content(),
          :path => [external_ids['category_id'], ext_ids['category_id']].join( '/')
      }
    end
  end





  def parse_place_by_category responce
    Nokogiri::HTML(responce).css('div.big-features-list div.feature').map do |div|
      ext_ids = {
          #get '912332' from 'feature_912332'
          'place_id' => div.attr('id').scan(/\d+/)[0],
      }
      {
          :external_ids => ext_ids,
          :title =>  div.css('h3 a')[0].content(),
          :contacts => {
              :address => div.css('div.feature-info div:nth-child(2)')[0].content().gsub(/.*: /, ''),
              :phone => div.css('div.feature-info div:nth-child(3)')[0].content().gsub(/.*: /, ''),
          },
          #get 'u8vwyre9uk' from 'var overlay = new Marker("feature_912332", "u8vwyre9uk", {"search_result":null,"textFlow":'
          :latlng => div.css('script')[0].content().scan(/"([a-z0-9]*)"/)[0][0],
          :path => ext_ids['place_id'],
      }
    end
  end

  def parse_siblings_place_by_category responce
    Nokogiri::HTML(responce).css('div.big-features-list div.lists-pagination a').map do |link|
      nr = link.content()
      next if (nr.to_i < 2)
      ext_ids = external_ids.clone
      ext_ids['page_nr'] = nr

      {
         :external_ids => ext_ids,

      }
    end
  end

  def save_simple(item, params = {})
    get_child_type.unscoped.find_or_create_by params.merge({:title =>  item[:title], :lang =>lang})
  end
  alias_method :save_city_by_main, :save_simple
  alias_method :save_category_by_city, :save_simple


  def save_category_by_category item
    params = {:parent_id => category.id}
    #category.children << save_simple(item, params)
    it = save_simple(item, params)
    it.move_to_child_of category
    it
  end

  def save_place_by_category item
    params = {
      :title => item[:title],
      :latlng => item[:latlng],
      :lang =>lang,
      :city_id => parent.parent.item_id,
    }

    pl = get_child_type.unscoped.where(params).first ||
        get_child_type.create(params.merge({:contacts => item[:contacts]}).merge(Decoder.decodeGeoHash(item[:latlng])))
    pl.categories << category
    pl
  end

#1000.times{Parse::Mapia.where(:children_found => nil).where('item_type != ?', 'Place').first.process}
end