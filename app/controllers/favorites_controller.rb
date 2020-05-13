class FavoritesController < ApplicationController
  def index
    @favorites = Pet.all_favorites
  end

  def create
    pet = Pet.find(params[:id])
    pet.update(favorite: true)
    flash[:notice] = "You have favorited #{pet.name}."
    redirect_to "/pets/#{params[:id]}"
  end
end
