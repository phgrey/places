
class Parsetask < ActiveRecord::Base
  #attr_accessible :responce, :source, :url, :lang, :level

  serialize :external_ids, Hash

  has_many :downloads
  has_many :children, :class_name => "Parsetask", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Parsetask"

  belongs_to :city, :polymorphic => true, :foreign_key => 'item_id', :foreign_type => 'item_type'
  belongs_to :category, :polymorphic => true, :foreign_key => 'item_id', :foreign_type => 'item_type'
  belongs_to :place, :polymorphic => true, :foreign_key => 'item_id', :foreign_type => 'item_type'

  def download_and_parse
    parse downloads.create_by_url(get_url)
  rescue
    false
  end

  def parse responce
    send('parse_'+get_level.to_s, responce)
  end

  def parse_siblings
    send('parse_siblings_'+get_level.to_s, downloads.last.responce).compact
  end

  def process
    I18n.locale = lang
    items_found = download_and_parse
    return update_attributes :children_found => -1 unless items_found
    items_found.each{|item_data|
      params = {:path => item_data[:path], :lang =>lang, :source => source}

      if( (existed = self.class.where(params).first))
        params[:item_id] = existed.item_id
        params[:item_type] = existed.item_type
        params[:external_ids] = item_data[:external_ids]
        children.create( params)
      else
        params[:external_ids] = item_data[:external_ids]
        save_item(item_data).parsetasks << children.create( params)
      end
    }
    update_attributes :children_found => items_found.length

    if(external_ids['page_nr'].to_i == 1)
      parse_siblings.each{|data|
        self.class.create(data.merge({
          :parent_id => parent_id,
          :item_id => item_id,
          :item_type => item_type,
          :source  => source,
          :lang => lang,
          :path => path
        }))
      }
    end
  end

  def save_item item
    send('save_'+get_level.to_s, item)
  end

  def self.root_tasks
    available_locales.map{|l|
      {
        :item_type => 'Main',
        :source => source_name,
        :lang => l.to_s
      }
    }
  end

  def self.create_roots
    root_tasks.map{|tsk|
      create tsk
    }
  end

  def get_level
    (get_child_type.name  + '_by_' +  item_type).downcase.to_sym
  end

  def get_url
    url = all_urls[get_level].clone
    #send('params_'+get_level.to_s).
    external_ids.each{|index, item| url = url.gsub(index.upcase, item.to_s)}
    url.gsub('LANG', lang)
  end

end