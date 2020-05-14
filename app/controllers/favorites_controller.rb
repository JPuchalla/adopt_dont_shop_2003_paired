class FavoritesController < ApplicationController
  def index
    @favorites = favorite.contents
  end

  def update
    pet = Pet.find(params[:id])
    favorite.fav_pet(pet)
    session[:favorite] = favorite.contents
    flash[:notice] = "You have favorited #{pet.name}."
    redirect_to "/pets/#{params[:id]}"
  end
end
