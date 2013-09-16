class CitiesController < ApplicationController
  def show
    return index if params[:city_id].nil?
    @city = City.find(params[:city_id])
    add_crumb @city.title, url_for(:city_id => @city.friendly_id)
    render 'show'
  end

  def index
    return show unless params[:city_id].nil?
    @cities = City.where(:lang => I18n.locale)
    render 'index'
  end

  def test
    @params = params
  end

  def unikalizator
    if params['text']
      @old_text = params['text']
      @text = UnikalizatorHelper::unikalizator_do_action params['text']
    else
      @old_text = ''
      @text = ''
    end
  end
end
