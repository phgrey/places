module UrlHelper
  def domain(locale_domain, city_id='')
    [city_id, locale_domain].keep_if{|item|item}.join '.'
  end

  def domain_url_for(options = nil)
    host = [options.delete(:city_id), options.delete(:locale_domain)||LOCALE_DOMAINS[I18n.locale.to_s]].keep_if{|item|item}.join '.'
    path = '/' + options[:caturlpath] if options[:caturlpath]
    path += '?page=' + options[:page].to_s if options[:page] &&  options[:page]   > 1
    [
        request.protocol,
        host,
        request.port_string,
        path
    ].join

  end

  def url_for options
    if options.kind_of?(Hash) && (options[:city_id] || options[:caturlpath])
      domain_url_for options
    else
      super options
    end
  end
end