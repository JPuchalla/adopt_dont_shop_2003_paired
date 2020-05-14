class RemoveFavoriteFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :favorite, :boolean
  end
end
