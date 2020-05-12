class FavoritesController < ApplicationController
  def index
    @favorites = Pet.all_favorites
  end
end
