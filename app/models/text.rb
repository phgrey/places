class Text < ActiveRecord::Base
  validates :lang, :item_type,  :presence => true
  #validates :text, :lang, :item_id, :item_type,  :presence => true
  validates :text, :length => {:in => 2..500, :allow_blank => true }
  validates :lang, :inclusion => { :in => I18n.available_locales.map{|loc| loc.to_s}}
  validates :item_type, :inclusion => {:in => %w(Offer Task User City)}

  belongs_to :user, :polymorphic => true, :inverse_of => :texts
  def self.new_for_each_locale(item_type)
    I18n.available_locales.map {|loc|
      new(:lang => loc.to_s, :item_type => item_type)
    }
  end
end
