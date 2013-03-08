class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  before_filter :generate_cats

  def generate_cats
    add_crumb I18n.t("Home"), root_path
    @cat_tree = Category.where(:lang => I18n.locale)
  end

  #def default_url_options(options={})
  #end

  def add_crumb(title, url=nil, options={})
    add_breadcrumb title, url, options
    @name = options[:title] || title
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => I18n.t(exception.message)
  end

end

