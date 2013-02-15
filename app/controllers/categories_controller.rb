class CategoriesController < ApplicationController
  # To change this template use File | Settings | File Templates.\

  def show
    @category = Category.bycaturlpath(params[:caturlpath])
    redirect_to category_path :caturlpath => @category.caturlpath  unless @category.caturlpath == params[:caturlpath]
    @places = Place.by_cat(@category).page(params[:page])
    if(params[:city_id])
      @city = City.find(params[:city_id])
      @places = @places.where(:city_id =>@city.id)
      add_crumb @city.title, url_for(@city)
    end
    @category.self_and_ancestors.each{|cat|
      add_crumb cat.title, @city.nil? ? category_path(:caturlpath => cat.caturlpath)
        : city_category_path(:city_id =>@city.friendly_id, :caturlpath=>cat.caturlpath)
    }
    respond_to do |format|
      format.html { render :template => "places/index" }
    end
  end
end