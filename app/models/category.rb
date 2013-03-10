class Category < ActiveRecord::Base
  acts_as_nested_set
  only_current_language

  extend FriendlyId
  friendly_id :title, :use => :slugged

  attr_accessible :title, :parent_id, :slug, :lang
  has_many :cattings
  has_many :places, :through => :cattings, :source => :cattable, :source_type => 'Place'
  has_many :cities, :through => :cattings, :source => :cattable, :source_type => 'City'
  has_many :parsetasks, :as => :item

  def caturlpath
    #self_and_ancestors.map{|a| a.slug}.join("/")
    #for two-levels will be enough
    (root? ? '' : (parent.friendly_id + '/')) + friendly_id
  end

  def self.bycaturlpath url
    self.find(url.split('/').last)
  end

  def open_tree
    self.class.open_tree self
  end

  def self.open_tree selected
    selected.nil? ? roots : where(parent_column_name => [nil, selected.parent_id, selected.id].uniq)
  end

  #TODO: add a bug to github awesome nested set
  def self_and_siblings
    super.where :lang=> I18n.locale
  end
end
