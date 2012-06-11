class City < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged


  attr_accessible :land, :title, :slug

  has_many :cattings, :as => :category
  has_many :offers, :through => :cattings, :source => :cattable, :source_type => 'Offer'

end
