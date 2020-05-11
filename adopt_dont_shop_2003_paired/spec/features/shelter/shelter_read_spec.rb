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

end
