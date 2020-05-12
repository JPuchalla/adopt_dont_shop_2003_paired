class AddFavoriteToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :favorite, :boolean
  end
end
