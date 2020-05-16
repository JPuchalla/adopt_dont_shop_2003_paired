class AdoptApplicationsController < ApplicationController
  def new
    @favorites = favorite.contents
  end

  def create
    applicant = AdoptApplication.create(application_params)
    params[:pet_ids].each do |pet_id|
      PetApplication.create(pet_id: pet_id, adopt_application_id: applicant.id)
      favorite.remove_fav(pet_id)
    end
    session[:favorite] = favorite.contents
    flash[:notice] = "Application submitted!"
    redirect_to "/favorites"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
