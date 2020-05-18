class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def read
    @pet = Pet.find(params[:id])
    if !@pet.pet_applications.find_by(approval: true).nil?
      @applicant = @pet.pet_applications.find_by(approval: true).adopt_application
    end
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    Pet.create(new_pet_params)
    redirect_to "/shelters/#{params[:id]}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  private
  def pet_params
    params.permit(:name, :image, :description, :approx_age, :sex)
  end

  def new_pet_params
    newpet_params = pet_params
    newpet_params[:shelter_id] = params[:id]
    newpet_params[:adopt_status] = "adoptable"
    newpet_params
  end
end
