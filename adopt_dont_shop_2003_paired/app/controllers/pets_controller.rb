class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def read
    @pet = Pet.find(params[:id])
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

  def adoptable
    pet = Pet.find(params[:id])
    pet.update(adopt_status: "adoptable")
    redirect_to "/pets/#{pet.id}"
  end

  def pending
    pet = Pet.find(params[:id])
    pet.update(adopt_status: "pending")
    redirect_to "/pets/#{pet.id}"
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
