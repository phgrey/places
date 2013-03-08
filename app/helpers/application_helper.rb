module ApplicationHelper
  def city_lis selected_city
    City.all.map { |city|
      url = complicated_url ({:city_id => city.friendly_id})
      cls = city == selected_city ? 'active' : ''
      "<li class=\"#{cls}\">#{link_to( city.title, url)}</li>"
    }.unshift("<li class=\"#{selected_city.nil? ? 'active' : ''}\">#{link_to( t('Ukraine'), complicated_url)}</li>").join('')
  end

  def category_in_city category, city=nil
    return category.title if city.nil?
    category.title + ' ' + city.in_city
  end

  def category_in_city_params cat, city=nil
    [
        cat.title,
        (city.nil? ? complicated_url(:caturlpath => cat.caturlpath)
          : complicated_url(:city_id =>city.friendly_id, :caturlpath=>cat.caturlpath)),
        {:title => category_in_city(cat, city)}
    ]
  end

  def link_to_category cat, city=nil
    link_to(*category_in_city_params(cat, city))
  end

  def complicated_url options={}
    return options if options.kind_of?(String)
    if options.kind_of?(Hash)
      options[:host] = [options.delete(:city_id)||'www', LOCALE_DOMAINS[(options.delete(:locale)||I18n.locale).to_s]].keep_if{|item|item}.join '.'
      options.except(:host).keys.count > 0 ?  category_url(options) : root_url(options)
    else
      url_for(options)
    end
  end
end
