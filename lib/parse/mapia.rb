require 'nokogiri'

class Parse::Mapia < Parse::Base
  def self.test
    1
  end

  @source = 'mapia'

  @locales = [:ru, :en, :ua]

  @urls = {
      :city_by_main => 'http://mapia.ua/LANG/kiev',
      :category_by_city => 'http://mapia.ua/LANG/city_id',
      :category_by_category => 'http://mapia.ua/LANG/city_id/category_id',
      :offer_by_category => 'http://mapia.ua/LANG/city_id/category_id'
  }

  def self.cities responce
    Nokogiri::HTML(responce).css('ul#city_list li a').map do |link|
      {
        #get 'vinn-itsa' from '/ru/vinn-itsa/remember_city?return=%2Fru%2Fvinnitsa'
        :external_id => link.attr('href').scan(/(?:ru|en|ua)\/([a-z-]*)/)[0][0],
        :title =>  link.content()
      }
    end
  end

end