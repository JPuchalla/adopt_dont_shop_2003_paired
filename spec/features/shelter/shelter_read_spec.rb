require 'rails_helper'

RSpec.describe "Shelter read page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")

    visit "/shelters/#{@shelter_1.id}"
  end

  it "shows user shelter info on page visit" do
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
  end

  it "has a link to the shelter's pets page" do
    click_button "Available Pets"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
  end

  it "has links to the shelter and pet indexes from shelter info page" do
    click_on "Shelter Index"
    expect(current_path).to eq("/shelters")
    click_link "#{@shelter_1.name}"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    click_on "Pet Index"
    expect(current_path).to eq("/pets")
  end

  it "has statistics for the shelter" do
    cassidy = Pet.create(image: "cute_dog.jpg",
                       name: "Cassidy",
                       description: "A very adorable pupper.",
                       approx_age: 10,
                       sex: "female",
                       adopt_status: 'adoptable',
                       shelter_id: @shelter_1.id)

    hobbes = Pet.create(image: "smug_cat.jpg",
                       name: "Hobbes",
                       description: "A very mischievous cat.",
                       approx_age: 5,
                       sex: "male",
                       adopt_status: 'adoptable',
                       shelter_id: @shelter_1.id)

    review_1 = Review.create(title: "Awesome place!",
                              rating: 5,
                              content: "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!",
                              image: nil,
                              shelter_id: @shelter_1.id)

    review_2 = Review.create(title: "Found the one",
                              rating: 4,
                              content: "It took us a bit of time, but we found that special little guy to bring home to the kids!",
                              image: nil,
                              shelter_id: @shelter_1.id)

    francis = AdoptApplication.create(name: "Francis",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231",
                               phone: "2023332291",
                               description: "I am a perfect human.")

    PetApplication.create(pet_id: cassidy.id, adopt_application_id: francis.id, approval: false)
    PetApplication.create(pet_id: hobbes.id, adopt_application_id: francis.id, approval: false)

    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Number of pets at this shelter: 2")
    expect(page).to have_content("Average rating of this shelter: 4.5")
    expect(page).to have_content("Applications on file at this shelter: 1")
  end

end
