class Place < ActiveRecord::Base
  attr_accessible :city_id, :contacts, :content, :lang, :title, :latlng, :longitude, :latitude

  serialize :contacts, Hash

  has_many :cattings, :as => :cattable
  has_many :categories, :through => :cattings, :source => :category, :source_type => 'Category'
  belongs_to :city
  has_many :parsetasks, :as => :item

end
