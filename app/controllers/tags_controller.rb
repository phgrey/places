class TagsController < ApplicationController
  # GET /tags
  # GET /tags.json
  def index
    @tags = Offer.tag_counts_on(:tags)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tags }
    end
  end

end
