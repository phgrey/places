class Text < ActiveRecord::Base
  validates :lang, :item_type,  :presence => true
  #validates :text, :lang, :item_id, :item_type,  :presence => true
  validates :text, :length => {:in => 2..500, :allow_blank => true }
  validates :lang, :inclusion => { :in => %w(ru en)}
  validates :item_type, :inclusion => {:in => %w(Offer Task User)}

  def self.new_for_each_locale(item_type)
    [
        new(:lang => 'ru', :item_type => item_type),
        new(:lang => 'en', :item_type => item_type),
    ]
  end
end
