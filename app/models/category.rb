class Category < ActiveRecord::Base
  acts_as_nested_set

  extend FriendlyId
  friendly_id :title, :use => :slugged

  attr_accessible :title, :parent_id, :slug, :lang
  has_many :cattings
  has_many :offers, :through => :cattings, :source => :cattable, :source_type => 'Offer'
  has_many :places, :through => :cattings, :source => :cattable, :source_type => 'Place'
  has_many :parsetasks, :as => :item

  def caturlpath
    self_and_ancestors.map{|a| a.slug}.join("/")
  end

  def self.bycaturlpath url
    self.find(url.split('/').last)
  end
end
