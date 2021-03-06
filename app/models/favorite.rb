class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Array.new
  end

  def fav_pet(pet_id)
    @contents << pet_id.to_i
  end

  def count_favorites
    @contents.count
  end

  def remove_fav(pet_id)
    @contents.delete(pet_id.to_i)
  end

  def in_favorites?(pet_id)
    @contents.include?(pet_id)
  end

  def get_pet(pet_id)
    Pet.find(pet_id)
  end

  def remove_all
    @contents.clear
  end

  def pets_w_apps
    @contents.find_all do |pet_id|
      !PetApplication.where("pet_id = #{pet_id}").empty?
    end
  end

  def pets_wo_apps
    @contents.find_all do |pet_id|
      PetApplication.where("pet_id = #{pet_id}").empty?
    end
  end
end
