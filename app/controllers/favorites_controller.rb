class FavoritesController < ApplicationController
  def index
    @favorites = favorite.contents
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorite.fav_pet(params[:pet_id])
    session[:favorite] = favorite.contents
    flash[:notice] = "You have favorited #{pet.name}."
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def delete
    pet = Pet.find(params[:pet_id])
    favorite.remove_fav(params[:pet_id])
    session[:favorite] = favorite.contents
    flash[:notice] = "Removed #{pet.name} from favorites."
    redirect_to params[:prev_page]
  end

  def destroy
    favorite.remove_all
    session[:favorite] = favorite.contents
    redirect_to "/favorites"
  end
end
