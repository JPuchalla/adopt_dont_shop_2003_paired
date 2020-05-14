class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Array.new
  end

  def fav_pet(pet)
    @contents << pet
  end

  def count_favorites
    @contents.count
  end

end
