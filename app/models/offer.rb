class Offer < ActiveRecord::Base
  attr_accessible :description, :hours, :tag_list, :texts_attributes, :text, :texts
  belongs_to :user
  has_many :texts, :foreign_key => 'item_id', :conditions => {:item_type => 'Offer'}
  #has_one :text, :foreign_key => 'item_id', :conditions => {:item_type => 'Offer', :lang=> I18n.locale}
  #has_and_belongs_to_many :tags, :uniq => true
  acts_as_taggable


  accepts_nested_attributes_for :texts, :allow_destroy => true

  #before_validation :remove_empty_texts

  self.per_page = 30

  define_index do
    indexes description
    indexes user.name, :as => :user, :sortable => true
    indexes taggings.tag.name, :as => :tags

    has user_id, created_at, updated_at
  end

  validates :description, :hours, :user_id, :texts, :presence => true
  validates :description, :length => {:in => 2..500}
  validates :hours, :numericality => {:only_integer => true}
  validates :tag_list, :length => {:maximum => 100}
  validates_each :texts do |record, attr, value|
    all_empty = true
    value.each {|v| all_empty &=v.text.blank?}
    if all_empty
      record.errors.add('texts', 'this is just for fun, only next error will be displayed')
      record.texts[0].errors.add('text', I18n.t('activerecord.errors.offer.texts'))
    end
  end



  def created_safe
    created_at ?  created_at  : Time.now - 1.year
  end

  def text
    Text.where('item_id'=> id ,'item_type' => 'Offer', 'lang'=> I18n.locale).limit(1).first.text
  end

  def self.new_w_texts
    new(:texts => Text.new_for_each_locale('Offer'))
  end

  #def remove_empty_texts
  #  texts.each{|t|
  #    t.attributes['_destroy'] =  t.text.nil?
  #  }
  #end

end
