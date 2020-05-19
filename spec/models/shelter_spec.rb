require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end
  describe "relationships" do
    it { should have_many :pets}
  end
  describe "methods" do
    before :each do
      @shelter = Shelter.create(name: "Dumb Friends League",
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
                         shelter_id: @shelter.id)

      @hobbes = Pet.create(image: "smug_cat.jpg",
                         name: "Hobbes",
                         description: "A mischievous cat.",
                         approx_age: 5,
                         sex: "M",
                         adopt_status: 'adoptable',
                         shelter_id: @shelter.id)
    end

    it "#all_adoptable" do
      first_pet = @shelter.pets.first
      first_adopt = @shelter.all_adoptable.first

      expect(first_pet).to eq(@cassidy)
      expect(first_adopt).to eq(@hobbes)
    end

    it "#all_pending" do
      last_pet = @shelter.pets.last
      last_pending = @shelter.all_pending.last

      expect(last_pet).to eq(@hobbes)
      expect(last_pending).to eq(@cassidy)
    end

  end
end
