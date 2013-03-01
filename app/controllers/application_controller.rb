class ApplicationController < ActionController::Base
  #include TheSortableTreeController::Rebuild
  protect_from_forgery
  include ApplicationHelper

  before_filter :set_locale
  before_filter :generate_cats

  def set_locale
    I18n.locale = LOCALE_DOMAINS.key(params[:locale_domain]) || I18n.default_locale

    #add_crumb I18n.t("Home"), root_path
  end

  def generate_cats
    @cat_tree = Category.where(:lang => I18n.locale)
  end

  def default_url_options(options={})
    #I18n.locale == I18n.default_locale ? {} : { :locale => I18n.locale }
    #{ :locale => I18n.locale == I18n.default_locale ? '' : I18n.locale }
    #{:locale => I18n.locale }.merge options
    {:locale_domain => LOCALE_DOMAINS[I18n.locale] }
  end

  def add_crumb(title, url=nil, options={})
    add_breadcrumb title, url, options
    @name = options[:title] || title
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => I18n.t(exception.message)
  end

end

