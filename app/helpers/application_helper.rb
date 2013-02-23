module ApplicationHelper
  def city_lis selected_city
    City.all.map { |city|
      url = url_for (city)
      cls = city == selected_city ? 'active' : ''
      "<li class=\"#{cls}\">#{link_to( city.title, url)}</li>"
    }.unshift("<li class=\"#{selected_city.nil? ? 'active' : ''}\">#{link_to( t('Ukraine'), '/')}</li>").join('')
  end

  def category_in_city category, city=nil
    return category.title if city.nil?
    category.title + ' ' + city.in_city
  end

  def category_in_city_params cat, city=nil
    [
        cat.title,
        (city.nil? ? category_path(:caturlpath=>cat.caturlpath)
          : city_category_path(:city_id =>city.friendly_id, :caturlpath=>cat.caturlpath)),
        {:title => category_in_city(cat, city)}
    ]
  end

  def link_to_category cat, city=nil
    link_to(*category_in_city_params(cat, city))
  end
end
