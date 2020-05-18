class AdoptApplicationsController < ApplicationController
  def new
    @favorites = favorite.contents
  end

  def create
    applicant = AdoptApplication.new(application_params)
    if !params[:pet_ids].nil? && applicant.save
      params[:pet_ids].each do |pet_id|
        PetApplication.create(pet_id: pet_id,
          adopt_application_id: applicant.id, approval: false)
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

  def read
    @applicant = AdoptApplication.find(params[:id])
  end

  def index
    @pet = Pet.find(params[:id])
    @applicants = @pet.adopt_applications
  end

  def edit
    pet = Pet.find(params[:id])
    pet.update(adopt_status: "pending")
    app = PetApplication.where("pet_id = #{pet.id} AND adopt_application_id = #{params[:applicant]}")
    app.first.update(approval: true)
    redirect_to "/pets/#{pet.id}"
  end

  def update
    applicant = AdoptApplication.find(params[:id])
    applicant.pets.each do |pet|
      pet.update(adopt_status: "pending")
    end
    flash[:notice] = "Application approved for all selections."
    redirect_to "/applications/#{applicant.id}"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
