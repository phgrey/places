module Domain

  class Match
    def matches?(request)
      if request.subdomain.present? && request.subdomain != 'www'
        request.path_parameters[:city_id] = request.subdomain
        dom = request.host.gsub request.subdomain + '.', ''
      else
        dom = request.host
      end

      I18n.locale = LOCALE_DOMAINS.key(dom) || I18n.default_locale


      return true
    end
  end

  module Mapper
    def domain
      constraints(Domain::Match.new) { yield }
    end
  end

=begin
  module Helper
    def url_for options
      return options if options.kind_of?(String)
      if options.kind_of?(Hash)
        options[:host] = [options.delete(:city_id), LOCALE_DOMAINS[(options.delete(:locale)||I18n.locale).to_s]].keep_if{|item|item}.join '.'
      end
      options.keys.count > 1 ?  super(options) : root_url(options)
    end
  end
=end
end