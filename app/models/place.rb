class Place < ActiveRecord::Base
  attr_accessible :city_id, :contacts, :content, :lang, :title, :latlng, :longitude, :latitude
  only_current_language
  default_scope :include => [:categories, :city],
                :order => "places.id DESC"
                #:conditions => "places.created_at<'#{Date.today}'"
  serialize :contacts, Hash

  has_many :cattings, :as => :cattable
  has_many :categories, :through => :cattings
  belongs_to :city
  has_many :parsetasks, :as => :item

  def self.by_cat cat
    condition = {cat.root? ? 'categories.parent_id' : 'categories.id' => cat.id}
    joins(:categories).where(condition)
    #above will be enough for the 2-level
    #joins(:categories).where("categories.lft >= :lft AND categories.rgt <= :rgt", {:lft => cat.lft, :rgt=> cat.rgt})
  end

  def page(*)
    super
    where(:lang => I18n.locale)
  end
end
