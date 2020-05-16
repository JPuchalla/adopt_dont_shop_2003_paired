class AdoptApplicationsController < ApplicationController
  def new
    @favorites = favorite.contents
  end

  def create
    applicant = AdoptApplication.new(application_params)
    if !params[:pet_ids].nil? && applicant.save
      params[:pet_ids].each do |pet_id|
        PetApplication.create(pet_id: pet_id, adopt_application_id: applicant.id)
        favorite.remove_fav(pet_id)
      end
      session[:favorite] = favorite.contents
      flash[:notice] = "Application submitted!"
      redirect_to "/favorites"
    else
      flash[:notice] = "Submission failed, please fill out all fields"
      redirect_to "/applications/new"
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
