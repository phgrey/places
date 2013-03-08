class CategoriesController < ApplicationController
  # To change this template use File | Settings | File Templates.\

  def show
    @category = Category.bycaturlpath(params[:caturlpath])
    return redirect_to category_path :caturlpath => @category.caturlpath  unless @category.caturlpath == params[:caturlpath]
    @places = Place.by_cat(@category).page(params[:page])
    if(params[:city_id])
      @city = City.find(params[:city_id])
      @places = @places.where(:city_id =>@city.id)
      add_crumb @city.title, complicated_url(:city_id =>@city.friendly_id)
    end
    @category.self_and_ancestors.each{|cat|
      add_crumb *category_in_city_params(cat, @city)
    }
    respond_to do |format|
      format.html { render :template => "places/index" }
    end
  end
end