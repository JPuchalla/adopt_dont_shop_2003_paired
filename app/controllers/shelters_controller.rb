class SheltersController < ApplicationController
  def index
    if params[:sort] == "alpha"
      @shelters = Shelter.order(:name)
    elsif params[:sort] == "by_pets"
      @shelters = Shelter.all.sort_by{|shelter| shelter.count_of_pets}.reverse
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
    shelter = Shelter.new(shelter_params)
    if shelter.save
      flash[:notice] = "Shelter Created!"
      redirect_to "/shelters"
    elsif shelter_params[:name] == ""
      flash[:notice] = "Missing name to create a shelter."
      redirect_to "/shelters/new"
    elsif shelter_params[:address] == ""
      flash[:notice] = "Missing address to create a shelter."
      redirect_to "/shelters/new"
    elsif shelter_params[:city] == ""
      flash[:notice] = "Missing city to create a shelter."
      redirect_to "/shelters/new"
    elsif shelter_params[:state] == ""
      flash[:notice] = "Missing state to create a shelter."
      redirect_to "/shelters/new"
    else
      flash[:notice] = "Missing zip code to create a shelter."
      redirect_to "/shelters/new"
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    if shelter.update(shelter_params)
      flash[:notice] = "Shelter Updated!"
      redirect_to "/shelters/#{shelter.id}"
    elsif shelter_params[:name] == ""
      flash[:notice] = "Missing name to update a shelter."
      redirect_to "/shelters/#{shelter.id}/edit"
    elsif shelter_params[:address] == ""
      flash[:notice] = "Missing address to update a shelter."
      redirect_to "/shelters/#{shelter.id}/edit"
    elsif shelter_params[:city] == ""
      flash[:notice] = "Missing city to update a shelter."
      redirect_to "/shelters/#{shelter.id}/edit"
    elsif shelter_params[:state] == ""
      flash[:notice] = "Missing state to update a shelter."
      redirect_to "/shelters/#{shelter.id}/edit"
    else
      flash[:notice] = "Missing zip code to update a shelter."
      redirect_to "/shelters/#{shelter.id}/edit"
    end

  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.all_pending.empty?
      shelter.pets.each {|pet| pet.destroy}
      shelter.reviews.each {|review| review.destroy}
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
