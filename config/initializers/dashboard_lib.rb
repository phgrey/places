require "lang_switcher"
ActiveRecord::Base.send(:extend, ActiveRecordLangFilter)
I18n.send(:extend, I18nActiveRecordSwitcher)

require "domain"
ActionDispatch::Routing::Mapper.send(:include, Domain::Mapper)
#ApplicationHelper.send(:include, Domain::Helper)

#Dir["subdomain/*.rb"].each {|file| require file }
#ActionDispatch::Routing::Mapper.send(:include, Subdomain::Extension)
#!TODO: move this to a domain
LOCALE_DOMAINS = YAML.load_file("config/domains.yml")[Rails.env]