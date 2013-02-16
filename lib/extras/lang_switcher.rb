module ActiveRecordLangFilter
  def only_current_language
    set_default_scope
    I18n.add_ar self
  end

  def set_default_scope
    default_scope :conditions => {:lang => I18n.locale}
  end
end

module I18nActiveRecordSwitcher
  def add_ar ar
    (@ars||=[]).push ar
  end

  def locale=(loc)
    loc = super loc
    @ars.each{|ar| ar.set_default_scope}
    loc
  end
end

