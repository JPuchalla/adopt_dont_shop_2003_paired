class AdoptApplicationsController < ApplicationController
  def new
    @favorites = favorite.contents
  end

  def create
    applicant = AdoptApplication.create(application_params)
    params[:pet_ids].each do |pet_id|
      applicant.apply_for_pet(pet_id)
      favorite.remove_fav(pet_id)
    end
    flash[:notice] = "Application submitted!"
    redirect_to "/favorites"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
