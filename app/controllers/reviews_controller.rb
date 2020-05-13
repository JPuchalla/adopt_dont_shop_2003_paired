class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    new_review = Review.new(new_review_params)
    if new_review.save
      redirect_to "/shelters/#{params[:id]}"
    else
      flash[:notice] = "Not enough information to submit review."
      redirect_to "/shelters/#{params[:id]}/reviews/new"
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
    @review = Review.find(params[:rid])
  end

  def update
    review = Review.find(params[:rid])
    if review.update(review_params)
      redirect_to "/shelters/#{params[:id]}"
    else
      flash[:notice] = "Not enough information to edit review."
      redirect_to "/shelters/#{params[:id]}/reviews/#{review.id}/edit"
    end
  end

  def destroy
    Review.destroy(params[:rid])
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
