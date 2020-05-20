require 'rails_helper'

RSpec.describe "Delete shelter", type: :feature do
  before :each do

      @shelter_1 = Shelter.create(name: "Dumb Friends League",
                                 address: "2080 S. Quebec St.",
                                 city: "Denver",
                                 state: "CO",
                                 zip: "80231")

      @shelter_2 = Shelter.create(name: "Denver Animal Shelter",
                                 address: "1241 W. Bayaud Ave.",
                                 city: "Denver",
                                 state: "CO",
                                 zip: "80223")

      @hobbes = Pet.create(image: "smug_cat.jpg",
                             name: "Hobbes",
                             description: "A very mischievous cat.",
                             approx_age: 5,
                             sex: "male",
                             adopt_status: 'adoptable',
                             shelter_id: @shelter_1.id)

      end
    it "deletes a shelter" do

    visit '/shelters'
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)

    visit "/shelters/#{@shelter_2.id}"
    click_button "Delete Shelter"
    expect(current_path).to eq("/shelters")

    expect(page).to have_content(@shelter_1.name)
    expect(page).to_not have_content(@shelter_2.name)
  end

  it "clicking delete button shows flash message" do
    peter = AdoptApplication.create(name: "Peter",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231",
                               phone: "2023332291",
                               description: "I am a perfect human.")

    PetApplication.create(pet_id: @hobbes.id, adopt_application_id: peter.id, approval: true)
    @hobbes.update(adopt_status: "pending")

    visit '/shelters'
    click_button "Delete #{@shelter_1.name}"
    expect(page).to have_content("Cannot delete Shelter with an approved application.")
    test_shelter = Shelter.find(@shelter_1.id)
    expect(test_shelter).to eq(@shelter_1)
  end

  it "can delete all pets with the shelter if there is no approved application" do
    visit '/shelters'
    click_button "Delete #{@shelter_1.name}"
    expect(page).to_not have_content(@shelter_1.name)
    visit '/pets'
    expect(page).to_not have_content(@hobbes.name)
  end

  it "can delete all reviews with the shelter" do
    review_1 = Review.create(title: "Awesome place!",
                            rating: 5,
                            content: "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!",
                            image: nil,
                            shelter_id: @shelter_1.id)

    visit '/shelters'
    click_button "Delete #{@shelter_1.name}"
    expect(page).to_not have_content(@shelter_1.name)
    expect(Review.exists?(review_1.id)).to eq(false)
  end
end
