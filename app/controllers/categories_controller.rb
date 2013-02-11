class CategoriesController < ApplicationController
  # To change this template use File | Settings | File Templates.\

  def show
    @category = Category.bycaturlpath(params[:caturlpath])
    redirect_to category_path :caturlpath => @category.caturlpath  unless @category.caturlpath == params[:caturlpath]
    @places = Place.by_cat(@category)
  end
end