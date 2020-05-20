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

    it "#count_of_pets" do
      expect(@shelter.count_of_pets).to eq(2)
    end

    it "#avg_review_rating" do
      review_1 = Review.create(title: "Awesome place!",
                                rating: 5,
                                content: "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!",
                                image: nil,
                                shelter_id: @shelter.id)

      review_2 = Review.create(title: "Found the one",
                                rating: 4,
                                content: "It took us a bit of time, but we found that special little guy to bring home to the kids!",
                                image: nil,
                                shelter_id: @shelter.id)

        expect(@shelter.avg_review_rating).to eq(4.5)
    end

    it "#count_of_apps" do
      francis = AdoptApplication.create(name: "Francis",
                                 address: "2080 S. Quebec St.",
                                 city: "Denver",
                                 state: "CO",
                                 zip: "80231",
                                 phone: "2023332291",
                                 description: "I am a perfect human.")

      john_jones = AdoptApplication.create(name: "John Jones",
                                  address: "Mars St",
                                  city: "Mars Capital",
                                  state: "MS",
                                  zip: "99999",
                                  phone: "9991112233",
                                  description: "Looking for an animal from a different planet.")

      PetApplication.create(pet_id: @cassidy.id, adopt_application_id: francis.id, approval: false)
      PetApplication.create(pet_id: @hobbes.id, adopt_application_id: francis.id, approval: false)

      expect(@shelter.count_of_apps).to eq(1)

      PetApplication.create(pet_id: @hobbes.id, adopt_application_id: john_jones.id, approval: false)

      expect(@shelter.count_of_apps).to eq(2)
    end

  end
end
