class OffersController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :get_offer_check_owner, :only => [:edit, :update, :destroy]
  before_filter :add_pager, :only => [:index, :tag]

  before_filter :set_crumb

  def set_crumb
    add_crumb I18n.t("Offers"), offers_path
  end


  def get_offer
    @offer = Offer.find(params[:id])
    add_crumb('#'+@offer.id.to_s, offer_path(@offer))
  end

  def get_offer_check_owner
    get_offer
    if current_user[:id] != @offer.user_id
      flash[:notice] = "Sorry, you can’t change this offer"
      redirect_to offers_path
    end
  end

  def add_pager
    @offers = Offer.page(params[:page])
  end
  
  # GET /offers
  # GET /offers.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @offers }
    end
  end

  def tag
    @tname = params[:tag]
    add_crumb I18n.t(:Tag_w_name, :name => @tname), tag_offers_path(@tname)
    @offers = @offers.tagged_with(@tname)
    respond_to do |format|
      format.html
      format.json { render :json => @offers }
    end
  end


  def search
    if(params[:s])
      redirect_to search_offers_path(params[:s])
    end

    @search = params[:search]
    add_crumb  I18n.t(:Search_w_name, :name => @search), search_offers_path(:search => @search)
    @offers = Offer.search(@search, :page => params[:page], :per_page=>Offer.per_page)
  end
  # GET /offers/1
  # GET /offers/1.json
  def show
    get_offer

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @offer }
    end
  end

  # GET /offers/new
  # GET /offers/new.json
  def new
    @offer = Offer.new
    add_crumb('new', new_offer_path)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @offer }
    end
  end

  # GET /offers/1/edit
  def edit
    add_crumb('edit', edit_offer_path(@offer))


  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(params[:offer])
    @offer.user = current_user
    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, :notice => 'Offer was successfully created.' }
        format.json { render :json => @offer, :status => :created, :location => @offer }
      else
        format.html { render :action => "new" }
        format.json { render :json => @offer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /offers/1
  # PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to @offer, :notice => 'Offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @offer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url }
      format.json { head :no_content }
    end
  end
end
