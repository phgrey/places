require "lang_switcher"

ActiveRecord::Base.send(:extend, ActiveRecordLangFilter)
I18n.send(:extend, I18nActiveRecordSwitcher)