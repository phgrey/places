require "journey/path/pattern"
require "journey/router/strexp"
require "journey/router/utils"

module Domain

  class Match
    def initialize(path, constraints = {})
#/var/lib/gems/1.9.1/gems/actionpack-3.2.12/lib/action_dispatch/routing/mapper.rb:218
      @pattern = Journey::Path::Pattern.new(
          Journey::Router::Strexp.compile(path, constraints, ['.'])
      )
    end

    def matches?(request)
#parameters extracting
#/var/lib/gems/1.9.1/gems/journey-1.0.4/lib/journey/router.rb:125
      match_data  = @pattern.match(request.host)
#seems that here we can define if route matches easier
#/var/lib/gems/1.9.1/gems/journey-1.0.4/lib/journey/gtg/simulator.rb:17, :21
      return false if match_data.nil?
      match_names = match_data.names.map { |n| n.to_sym }
      match_values = match_data.captures.map { |v| v && Journey::Router::Utils.unescape_uri(v) }
      info = Hash[match_names.zip(match_values).find_all { |_,y| y }]
      info.each { |key, value| request.path_parameters[key] = value }
      true
    end
  end

  module Mapper
    def domain(*anything)
      constraints(Domain::Match.new *anything) { yield }
    end
  end
end