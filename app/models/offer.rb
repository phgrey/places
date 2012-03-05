class Offer < ActiveRecord::Base
  attr_accessible :description, :hours, :tag_list
  belongs_to :user
  #has_and_belongs_to_many :tags, :uniq => true
  acts_as_taggable



  self.per_page = 30

  define_index do
    indexes description
    indexes user.name, :as => :user, :sortable => true
    indexes taggings.tag.name, :as => :tags

    has user_id, created_at, updated_at
  end

  def created_safe
    created_at ?  created_at  : Time.now - 1.year
  end

  validates :description, :hours, :user_id, :presence => true
  validates :description, :length => {:in => 2..500}
  validates :hours, :numericality => {:only_integer => true}
  validates :tag_list, :length => {:maximum => 100}
end
