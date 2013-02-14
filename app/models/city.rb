class City < ActiveRecord::Base
  extend FriendlyId
  only_current_language

  friendly_id :title, :use => :slugged


  attr_accessible :lang, :title, :slug

  has_many :cattings, :as => :category
  has_many :offers, :through => :cattings, :source => :cattable, :source_type => 'Offer'
  has_many :parsetasks, :as => :item
end
