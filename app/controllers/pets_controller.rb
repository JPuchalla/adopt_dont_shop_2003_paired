class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
    if !@pet.pet_applications.find_by(approval: true).nil?
      @applicant = @pet.pet_applications.find_by(approval: true).adopt_application
    end
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    pet = Pet.new(new_pet_params)
    if pet.save
      flash[:notice] = "Pet created!"
      redirect_to "/shelters/#{params[:id]}/pets"
    elsif new_pet_params[:name] == ""
      flash[:notice] = "Missing name to create a pet."
      redirect_to "/shelters/#{params[:id]}/pets/new"
    elsif new_pet_params[:image] == ""
      flash[:notice] = "Missing image to create a pet."
      redirect_to "/shelters/#{params[:id]}/pets/new"
    elsif new_pet_params[:description] == ""
      flash[:notice] = "Missing description to create a pet."
      redirect_to "/shelters/#{params[:id]}/pets/new"
    elsif new_pet_params[:approx_age] == ""
      flash[:notice] = "Missing approximate age to create a pet."
      redirect_to "/shelters/#{params[:id]}/pets/new"
    else
      flash[:notice] = "Missing sex to create a pet."
      redirect_to "/shelters/#{params[:id]}/pets/new"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    if pet.update(pet_params)
      flash[:notice] = "Pet updated!"
      redirect_to "/pets/#{pet.id}"
    elsif pet_params[:name] == ""
      flash[:notice] = "Missing name to update a pet."
      redirect_to "/pets/#{pet.id}/edit"
    elsif pet_params[:image] == ""
      flash[:notice] = "Missing image to update a pet."
      redirect_to "/pets/#{pet.id}/edit"
    elsif pet_params[:description] == ""
      flash[:notice] = "Missing description to update a pet."
      redirect_to "/pets/#{pet.id}/edit"
    elsif pet_params[:approx_age] == ""
      flash[:notice] = "Missing approximate age to update a pet."
      redirect_to "/pets/#{pet.id}/edit"
    else
      flash[:notice] = "Missing sex to update a pet."
      redirect_to "/pets/#{pet.id}/edit"
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.is_adoptable?
      pet.destroy
    else
      flash[:notice] = "Cannot delete pet with an approved application."
    end
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
