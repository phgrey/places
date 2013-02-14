class CategoriesController < ApplicationController
  # To change this template use File | Settings | File Templates.\

  def show
    @category = Category.bycaturlpath(params[:caturlpath])
    redirect_to category_path :caturlpath => @category.caturlpath  unless @category.caturlpath == params[:caturlpath]
    @category.self_and_ancestors.each{|cat|
      add_crumb cat.title, cat.caturlpath
    }
    @places = Place.by_cat(@category).page(params[:page])

    respond_to do |format|
      format.html { render :template => "places/index" }
    end
  end
end