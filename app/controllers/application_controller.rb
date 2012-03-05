class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    add_crumb I18n.t("Home"), root_path
  end

  def default_url_options(options={})
    #I18n.locale == I18n.default_locale ? {} : { :locale => I18n.locale }
    #{ :locale => I18n.locale == I18n.default_locale ? '' : I18n.locale }
  { :locale => I18n.locale }
  end

end
