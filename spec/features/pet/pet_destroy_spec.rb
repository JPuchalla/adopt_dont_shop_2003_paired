require 'rails_helper'

RSpec.describe "Delete pet", type: :feature do
  before :each do

    @shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")

    @peter = AdoptApplication.create(name: "Peter",
                                 address: "2080 S. Quebec St.",
                                 city: "Denver",
                                 state: "CO",
                                 zip: "80231",
                                 phone: "2023332291",
                                 description: "I am a perfect human.")

    @cassidy = Pet.create(image: "cute_dog.jpg",
                       name: "Cassidy",
                       description: "A very adorable pupper.",
                       approx_age: 10,
                       sex: "female",
                       adopt_status: 'pending',
                       shelter_id: @shelter_1.id)

    @hobbes = Pet.create(image: "smug_cat.jpg",
                       name: "Hobbes",
                       description: "A very mischievous cat.",
                       approx_age: 5,
                       sex: "male",
                       adopt_status: 'adoptable',
                       shelter_id: @shelter_1.id)
    end

    it "deletes a pet" do

    visit '/pets'
    expect(page).to have_content(@cassidy.name)
    expect(page).to have_content(@hobbes.name)

    visit "/pets/#{@hobbes.id}"
    click_button "Delete Pet"
    expect(current_path).to eq("/pets")

    expect(page).to have_content(@cassidy.name)
    expect(page).to_not have_content(@hobbes.name)
  end

  it "clicking delete button shows flash message" do

    PetApplication.create(pet_id: @hobbes.id, adopt_application_id: @peter.id, approval: true)
    @hobbes.update(adopt_status: "pending")

    visit "/pets/#{@hobbes.id}"
    click_button "Delete Pet"
    expect(page).to have_content("Cannot delete pet with an approved application.")
    test_pet = Pet.find(@hobbes.id)
    expect(test_pet).to eq(@hobbes)
  end
end
