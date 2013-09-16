class PlacesController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :create, :update, :destroy]
  before_filter :set_crumb
  before_filter :get_offer, :only => [:edit, :update, :destroy, :show]
  before_filter :add_pager, :only => [:index,]

  # GET /places
  # GET /places.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @place }
    end
  end

  protected
  def set_crumb
    add_crumb I18n.t("Places.many"), places_path
  end

  def get_item
    id = params[:id]
    @place = Place.find(id)
    add_crumb('#'+@place.id.to_s, place_path(@place))
  end

  def add_pager
    @places = Place.page(params[:page])
  end
end
