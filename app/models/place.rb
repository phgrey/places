class Place < ActiveRecord::Base
  attr_accessible :city_id, :contacts, :content, :lang, :title, :latlng, :longitude, :latitude
  only_current_language

  serialize :contacts, Hash

  has_many :cattings, :as => :cattable
  has_many :categories, :through => :cattings, :source => :category, :source_type => 'Category'
  belongs_to :city
  has_many :parsetasks, :as => :item

  def self.by_cat cat
    joins(:categories).where("categories.lft >= :lft AND categories.rgt <= :rgt", {:lft => cat.lft, :rgt=> cat.rgt})
  end

  def page(*)
    super
    where(:lang => I18n.locale)
  end
end
