module ActiveRecordLangFilter
  def only_current_language
    default_scope lambda {where(:lang => I18n.locale)}
  end
end