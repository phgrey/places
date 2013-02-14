module ActiveRecordLangFilter
    def only_current_language
      default_scope :conditions => {:lang => I18n.locale}
    end
end

# include the extension
