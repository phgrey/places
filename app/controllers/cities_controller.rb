class CitiesController < ApplicationController
  def show
    return index if params[:city_id].nil?
    @city = City.find(params[:city_id])
    add_crumb @city.title, url_for(:city_id => @city.friendly_id)
  end

  def index
    @cities = City.limit(10).where(:lang => I18n.locale)
    @cities2 = City.limit(10)

  end

  def test
    @params = params
  end
end
