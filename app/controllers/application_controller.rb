class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  before_filter :main_crumb
  #before_filter :miniprofiler unless Rails.env == 'production'
  #def default_url_options(options={})
  #end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => I18n.t(exception.message)
  end

  protected

  def main_crumb
    add_crumb I18n.t("Home"), complicated_url
  end

  def add_crumb(title, url=nil, options={})
    add_breadcrumb title, url, options
    @name = options[:title] || title
  end

  def miniprofiler
    Rack::MiniProfiler.authorize_request
  end

end

