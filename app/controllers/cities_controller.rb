class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    add_crumb @city.title, url_for(@city)
  end

  def index

  end
end
