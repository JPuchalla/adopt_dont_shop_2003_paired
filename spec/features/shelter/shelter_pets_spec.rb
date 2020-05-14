require 'rails_helper'

RSpec.describe "Shelter pets page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")

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

    visit "/shelters/#{@shelter_1.id}/pets"
  end

  it "shows user all pets from a shelter" do
    expect(page).to have_content(@cassidy.name)
    expect(page).to have_content(@cassidy.approx_age)
    expect(page).to have_content(@cassidy.sex)
    expect(page).to have_content(@hobbes.name)
    expect(page).to have_content(@hobbes.approx_age)
    expect(page).to have_content(@hobbes.sex)
  end

  it "has a link for each pet in their name" do
    click_link "#{@hobbes.name}"
    expect(current_path).to eq("/pets/#{@hobbes.id}")
  end

  it "has links to the shelter and pet indexes from shelter pets list page" do
    click_on "Shelter Index"
    expect(current_path).to eq("/shelters")
    click_link "#{@shelter_1.name}"
    click_button "Available Pets"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
    click_on "Pet Index"
    expect(current_path).to eq("/pets")
  end

  it "can count the number of pets in the shelter" do
    expect(page).to have_content("There are 2 pets at the shelter")
  end

  it "can check if adoptable pets comes before pets pending adoption" do
    expect(page.body.index(@hobbes.name)).to be < page.body.index(@cassidy.name)
  end

  it "can filter adoptable or pending adoption pets" do
    expect(page).to have_content("All Pets")
    expect(page).to have_content(@cassidy.name)
    expect(page).to have_content(@hobbes.name)
    expect(page).to_not have_link "Show All Pets"
    expect(page).to have_link "Show Only Pets Pending Adoption"
    click_on "Show Only Adoptable Pets"

    expect(page).to have_content("Adoptable Pets")
    expect(page).to_not have_content(@cassidy.name)
    expect(page).to have_content(@hobbes.name)
    expect(page).to_not have_link "Show Only Adoptable Pets"
    expect(page).to have_link "Show All Pets"
    click_on "Show Only Pets Pending Adoption"

    expect(page).to have_content("Pets Pending Adoption")
    expect(page).to have_content(@cassidy.name)
    expect(page).to_not have_content(@hobbes.name)
    expect(page).to_not have_link "Show Only Pets Pending Adoption"
    expect(page).to have_link "Show Only Adoptable Pets"
    click_on "Show All Pets"

    expect(page).to have_content("All Pets")
    expect(page).to have_content(@cassidy.name)
    expect(page).to have_content(@hobbes.name)
  end

end
