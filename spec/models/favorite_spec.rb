require 'rails_helper'

describe Favorite, type: :model do
  describe "methods" do
    before :each do
      shelter_1 = Shelter.create(name: "Dumb Friends League",
                                 address: "2080 S. Quebec St.",
                                 city: "Denver",
                                 state: "CO",
                                 zip: "80231")

      @cassidy = Pet.create(image: "cute_dog.jpg",
                     name: "Cassidy",
                     description: "A very adorable pupper.",
                     approx_age: 10,
                     sex: "F",
                     adopt_status: 'pending',
                     shelter_id: shelter_1.id)

      @hobbes = Pet.create(image: "smug_cat.jpg",
                     name: "Hobbes",
                     description: "A very mischievous cat.",
                     approx_age: 5,
                     sex: "M",
                     adopt_status: 'adoptable',
                     shelter_id: shelter_1.id)
        @favs = Favorite.new([@cassidy.id])
      end
      it "#count_favorites" do
        expect(@favs.count_favorites).to eq(1)
      end
      it "#fav_pet" do
        @favs.fav_pet(@hobbes.id)
        expect(@favs.contents).to eq([@cassidy.id, @hobbes.id])
      end
  end
end
