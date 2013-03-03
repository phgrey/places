
#неудачная попытка сделать красивый роутинг по субдоменам
#планировалось использовать ьак
#scope 'dashboard.my/(:locale)', :locale => Regexp.new(I18n.available_locales.join('|')) do
module FullPath
  class Test
    def pattern
      return @pattern unless @pattern.nil?
      domains = %w(dashboard.my ru.my en.my ua.my)
      constraints = {
        :domain => Regexp.new(domains.map{|d|d.gsub(".",'\.')}.join('|'))

      }
      #1. Here is example of creating the patterns
      @pattern = Journey::Path::Pattern.new(
          Journey::Router::Strexp.compile('(:city_id.)*domain', constraints, ['.', '/', '?', ':'])
      )
    end

    def parse path
      parse_pattern path, pattern
    end

    protected
    def parse_pattern path, pattern
      match_data  = pattern.match(path)
  #seems that here we can define if route matches easier
  #/var/lib/gems/1.9.1/gems/journey-1.0.4/lib/journey/gtg/simulator.rb:17, :21
      return false if match_data.nil?
      match_names = match_data.names.map { |n| n.to_sym }
      match_values = match_data.captures.map { |v| v && Journey::Router::Utils.unescape_uri(v) }
      Hash[match_names.zip(match_values).find_all { |_,y| y }]
    end
  end
end

  #extend Journey::Router.new().find_routes
  #Journey::Router.send(:include, FullPath::Router)
  #module  FullPath::Router
  class  Journey::Router

    private

    def find_routes env
      req = request_class.new env

      routes = filter_routes(req.full_path) + custom_routes.find_all { |r|
        r.path.match(req.full_path)
      }

      routes = routes.sort_by(&:precedence).find_all { |r|
        r.constraints.all? { |k,v| v === req.send(k) } &&
            r.verb === req.request_method
      }.reject { |r| req.ip && !(r.ip === req.ip) }.map { |r|
        match_data  = r.path.match(req.full_path)
        match_names = match_data.names.map { |n| n.to_sym }
        match_values = match_data.captures.map { |v| v && Utils.unescape_uri(v) }
        info = Hash[match_names.zip(match_values).find_all { |_,y| y }]

        [match_data, r.defaults.merge(info), r]
      }
      #routes.empty? ? find_routes_old(env) : routes
    end

    def find_routes_old env
      req = request_class.new env

      routes = filter_routes(req.path_info) + custom_routes.find_all { |r|
        r.path.match(req.path_info)
      }

      routes.sort_by(&:precedence).find_all { |r|
        r.constraints.all? { |k,v| v === req.send(k) } &&
            r.verb === req.request_method
      }.reject { |r| req.ip && !(r.ip === req.ip) }.map { |r|
        match_data  = r.path.match(req.path_info)
        match_names = match_data.names.map { |n| n.to_sym }
        match_values = match_data.captures.map { |v| v && Utils.unescape_uri(v) }
        info = Hash[match_names.zip(match_values).find_all { |_,y| y }]

        [match_data, r.defaults.merge(info), r]
      }
    end
  end



  #2.1 parameters extracting
  #/var/lib/gems/1.9.1/gems/journey-1.0.4/lib/journey/router.rb:125
  #seems we have to override ActionDispatch::Request.new().path_info
  #   break on /var/lib/gems/1.9.1/gems/journey-1.0.4/lib/journey/router.rb:49
  #ActionDispatch::Request.send(:include, FullPath::Request)
  #module FullPath::Request
  class ActionDispatch::Request
    def full_path
      '/'+host+path_info
    end
  end
  #part2 - replacing path with host+'/'+path



  #2.2 seems that here we can define if route matches easier
  #/var/lib/gems/1.9.1/gems/journey-1.0.4/lib/journey/gtg/simulator.rb:17, :21

