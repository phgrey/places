class City < ActiveRecord::Base
  #extend FriendlyId
  only_current_language

  #friendly_id :title, :use => :slugged

  has_many :cattings, :as => :cattable
  has_many :categories, :through => :cattings
  has_many :places
  has_one :text, :as => :item
  has_many :parsetasks, :as => :item
  #attr_accessible :lang, :title, :slug, :text_attributes
  accepts_nested_attributes_for :text

  def in_city
    Case.where(:source => title).pluck('d')[0] || title
  end

  #protected
  def give_categories_by_places
    I18n.locale = lang
    sql = ActiveRecord::Base.connection()
    cats = sql.execute(places.joins(:categories).select([:lft, :rgt, 'places.created_at']).uniq.to_sql)
    condition = cats.map{|cat|
        ['(lft <', cat['lft'].to_i+1,'AND', cat['rgt'].to_i-1, '< rgt)'].join ' '
      }.join(' OR ')
    self.categories = condition == '' ? [] : Category.where(condition).uniq
#this block seems to be more quick, but I do not like it
=begin
    sql.execute("DELETE FROM cattings WHERE cattable_id = #{id} AND cattable_type = 'City' AND category_type = 'Category'")
    return if condition == ''
    sql.execute("INSERT INTO cattings (category_id, category_type, cattable_id, cattable_type)
      SELECT DISTINCT id, 'Category', #{id}, 'City' FROM categories WHERE #{condition}")
=end
  end


  #City.unscoped.all.each{|city| city.give_categories_by_places}
end
