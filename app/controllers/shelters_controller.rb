class SheltersController < ApplicationController
  def index
    if params[:sort] == "alpha"
      @shelters = Shelter.order(:name)
    elsif params[:sort] == "by_pets"
      @shelters = Shelter.all.sort_by{|shelter| shelter.pets.number_pets}.reverse
    else
      @shelters = Shelter.all
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = Review.where("shelter_id = #{@shelter.id}")
  end

  def new

  end

  def create
    Shelter.create(shelter_params)
    redirect_to "/shelters"
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.all_pending.empty?
      shelter.pets.each {|pet| pet.destroy}
      shelter.destroy
    else
      flash[:notice] = "Cannot delete Shelter with an approved application."
    end
    redirect_to "/shelters"
  end

  def pets
    @adoptable = ActiveModel::Type::Boolean.new.cast(params[:adoptable])
    @shelter = Shelter.find(params[:id])
    @adopt = @shelter.all_adoptable
    @pending = @shelter.all_pending
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
