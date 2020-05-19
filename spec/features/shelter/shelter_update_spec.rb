require 'rails_helper'

RSpec.describe "Shelter update", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")

    visit "/shelters/#{@shelter_1.id}"
  end

  it "updates a shelter" do
    click_button "Update Shelter"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

    fill_in :name, with: "Monterey Bay Aquarium"
    fill_in :address, with: "886 Cannery Row"
    fill_in :city, with: "Monterey"
    fill_in :state, with: "CA"
    fill_in :zip, with: "93940"
    click_button "Update Shelter"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("Monterey Bay Aquarium")
    expect(page).to have_content("886 Cannery Row")
    expect(page).to have_content("Monterey")
    expect(page).to have_content("CA")
    expect(page).to have_content("93940")
  end

  it "has links to the shelter and pet indexes from shelter edit page" do
    click_button "Update Shelter"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
    click_on "Shelter Index"
    expect(current_path).to eq("/shelters")
    click_link "#{@shelter_1.name}"
    click_on "Update Shelter"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
    click_on "Pet Index"
    expect(current_path).to eq("/pets")
  end

  it "has a flash message indicating which fields are missing" do
    click_button "Update Shelter"

    fill_in :name, with: nil
    click_button "Update Shelter"
    expect(page).to have_content("Missing name to update a shelter.")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

    fill_in :address, with: nil
    click_button "Update Shelter"
    expect(page).to have_content("Missing address to update a shelter.")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

    fill_in :city, with: nil
    click_button "Update Shelter"
    expect(page).to have_content("Missing city to update a shelter.")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

    fill_in :state, with: nil
    click_button "Update Shelter"
    expect(page).to have_content("Missing state to update a shelter.")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

    fill_in :zip, with: nil
    click_button "Update Shelter"
    expect(page).to have_content("Missing zip code to update a shelter.")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
  end

end
