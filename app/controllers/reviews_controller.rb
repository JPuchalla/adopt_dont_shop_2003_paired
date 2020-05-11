class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    Review.create(new_review_params)
    redirect_to "/shelters/#{params[:id]}"
  end

  private
  def review_params
    params.permit(:title, :image, :rating, :content)
  end

  def new_review_params
    newreview_params = review_params
    newreview_params[:shelter_id] = params[:id]
    newreview_params
  end
end
