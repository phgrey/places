class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    add_crumb @city.title, url_for(@city)
  end

  def index
    @cities = City.limit(10).where(:lang => I18n.locale)
    @cities2 = City.limit(10)

  end
end
