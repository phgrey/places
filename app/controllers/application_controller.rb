class ApplicationController < ActionController::Base
  #include TheSortableTreeController::Rebuild
  protect_from_forgery

  before_filter :set_locale
  before_filter :generate_cats

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    #folowing check is moved to the routes.rb
    #parsed_locale = params[:locale] || I18n.default_locale
    #I18n.locale = I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
    add_crumb I18n.t("Home"), root_path
  end

  def generate_cats
    @cat_tree = Category.where(:lang => I18n.locale)
  end

  def default_url_options(options={})
    #I18n.locale == I18n.default_locale ? {} : { :locale => I18n.locale }
    #{ :locale => I18n.locale == I18n.default_locale ? '' : I18n.locale }
  { :locale => I18n.locale }
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => I18n.t(exception.message)
  end

end

