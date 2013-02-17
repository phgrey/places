class City < ActiveRecord::Base
  extend FriendlyId
  only_current_language

  friendly_id :title, :use => :slugged


  attr_accessible :lang, :title, :slug

  has_many :cattings, :as => :cattable
  has_many :categories, :through => :cattings, :source => :category, :source_type => 'Category'
  has_many :places
  has_one :text, :as => :item
  has_many :parsetasks, :as => :item

  #protected
  def give_categories_by_places
    condition = places.joins(:categories).select("lft, rgt").uniq
      .map{|cat| ['(lft <', cat.lft.to_i+1,'AND', cat.rgt.to_i-1, '< rgt)'].join ' ' }
      .join(' OR ')
    self.categories = condition == '' ? [] : Category.where(condition).uniq
#this block seems to be more quick, but I do not like it
=begin
    sql = ActiveRecord::Base.connection()
    sql.execute("DELETE FROM cattings WHERE cattable_id = #{id} AND cattable_type = 'City' AND category_type = 'Category'")
    return if condition == ''
    sql.execute("INSERT INTO cattings (category_id, category_type, cattable_id, cattable_type)
      SELECT DISTINCT id, 'Category', #{id}, 'City' FROM categories WHERE #{condition}")
=end
  end


  #City.unscoped.all.each{|city| city.give_categories_by_places}
end
