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

  def show
    @applicant = AdoptApplication.find(params[:id])
  end

  def index
    @pet = Pet.find(params[:id])
    @applicants = @pet.adopt_applications
  end

  def edit
    pet = Pet.find(params[:id])
    if pet.adopt_status != "pending"
      pet.update(adopt_status: "pending")
      app = PetApplication.where("pet_id = #{pet.id} AND adopt_application_id = #{params[:applicant]}")
      app.first.update(approval: true)
      redirect_to "/pets/#{pet.id}"
    else
      flash[:notice] = "#{pet.name} is pending adoption elsewhere."
      redirect_to "/applications/#{params[:applicant]}"
    end
  end

  def update
    applicant = AdoptApplication.find(params[:id])
    pets = params[:pet_ids]
    if !pets.nil? && all_adoptable?(pets)
      pets.each do |pet_id|
        Pet.find(pet_id).update(adopt_status: 'pending')
        app = PetApplication.where("pet_id = #{pet_id} AND adopt_application_id = #{applicant.id}")
        app.first.update(approval: true)
      end
      flash[:notice] = "Application approved for all selections."
    elsif !pets.nil?
      flash[:notice] = "A pet you selected is pending adoption elsewhere."
    else
      flash[:notice] = "You didn't select any pets."
    end
    redirect_to "/applications/#{applicant.id}"
  end

  def delete
    pet = Pet.find(params[:id])
    pet.update(adopt_status: 'adoptable')
    app = PetApplication.where("pet_id = #{pet.id} AND adopt_application_id = #{params[:applicant]}")
    app.first.update(approval: false)
    redirect_to "/applications/#{params[:applicant]}"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end

  def all_adoptable?(pet_ids)
    pet_ids.each do |pet_id|
      if !Pet.find(pet_id).is_adoptable?
        return false
      end
    end
    true
  end
end
