module ApplicationHelper
  def city_lis selected_city
    City.all.map { |city|
      url = city_path (city)
      cls = city == selected_city ? 'active' : ''
      "<li class=\"#{cls}\">#{link_to( city.title, url)}</li>"
    }.unshift("<li class=\"#{selected_city.nil? ? 'active' : ''}\">#{link_to( t('Ukraine'), '/')}</li>").join('')
  end
end
