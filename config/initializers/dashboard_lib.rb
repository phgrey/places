require "active_record_extensions"

ActiveRecord::Base.send(:extend, ActiveRecordLangFilter)