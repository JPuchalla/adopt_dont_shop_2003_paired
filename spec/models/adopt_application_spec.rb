require 'rails_helper'

describe AdoptApplication, type: :model do
  describe "validations" do
    it { should validate_presence_of :name
         should validate_presence_of :address
         should validate_presence_of :city
         should validate_presence_of :state
         should validate_presence_of :zip
         should validate_presence_of :phone
         should validate_presence_of :description }
  end
  describe "relationships" do
    it { should have_many :pet_applications}
    it { should have_many(:pets).through(:pet_applications)}
  end
  describe "methods" do
    before :each do
      @francis = AdoptApplication.create(name: "Francis",
                                         address: "2080 S. Quebec St.",
                                         city: "Denver",
                                         state: "CO",
                                         zip: "80231",
                                         phone: "2023332291",
                                         description: "I am a perfect human.")

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
                         adopt_status: 'pending',
                         shelter_id: @shelter.id)

      @john_jones = AdoptApplication.create(name: "John Jones",
                                  address: "Mars St",
                                  city: "Mars Capital",
                                  state: "MS",
                                  zip: "99999",
                                  phone: "9991112233",
                                  description: "Looking for an animal from a different planet.")

      PetApplication.create(pet_id: @cassidy.id, adopt_application_id: @francis.id, approval: false)
      PetApplication.create(pet_id: @hobbes.id, adopt_application_id: @francis.id, approval: true)
      PetApplication.create(pet_id: @cassidy.id, adopt_application_id: @john_jones.id, approval: true)
    end

    it "#is_approved_for_pet?" do
      expect(@francis.is_approved_for_pet?(@hobbes.id)).to eq(true)
      expect(@francis.is_approved_for_pet?(@cassidy.id)).to eq(false)
      expect(@john_jones.is_approved_for_pet?(@cassidy.id)).to eq(true)
    end

  end
end
