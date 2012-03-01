class Offer < ActiveRecord::Base
  #attr_accessible :description, :hours, :tag_ids
  attr_accessible :description, :hours, :tag_list
  belongs_to :user
  #has_and_belongs_to_many :tags, :uniq => true
  acts_as_taggable
  self.per_page = 30
end
