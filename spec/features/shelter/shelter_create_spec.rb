require 'rails_helper'

RSpec.describe "Create shelter page", type: :feature do
  it "creates a new shelter" do
    visit '/shelters'
    click_button "New Shelter"
    expect(current_path).to eq('/shelters/new')

    fill_in :name, with: "Dumb Friends League"
    fill_in :address, with: "2080 S. Quebec St."
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80231"
    click_button "Create Shelter"

    new_shelter = Shelter.last
    expect(new_shelter.name).to eq("Dumb Friends League")
    expect(new_shelter.address).to eq("2080 S. Quebec St.")
    expect(new_shelter.city).to eq("Denver")
    expect(new_shelter.state).to eq("CO")
    expect(new_shelter.zip).to eq("80231")
    expect(current_path).to eq('/shelters')
    expect(page).to have_content(new_shelter.name)
  end

  it "has links to the shelter and pet indexes from shelter create page" do
    visit '/shelters'
    click_button "New Shelter"
    expect(current_path).to eq('/shelters/new')
    click_on "Shelter Index"
    expect(current_path).to eq('/shelters')

    click_button "New Shelter"
    expect(current_path).to eq('/shelters/new')
    click_on "Pet Index"
    expect(current_path).to eq('/pets')
  end

  it "shows a flash message when submitting incomplete information for a shelter" do

    visit '/shelters'
    click_button "New Shelter"

    fill_in :address, with: "2080 S. Quebec St."
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80231"
    click_button "Create Shelter"
    expect(current_path).to eq('/shelters/new')
    expect(page).to have_content("Insufficient Information to create a shelter.")

    fill_in :name, with: "Dumb Friends League"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80231"
    click_button "Create Shelter"
    expect(current_path).to eq('/shelters/new')
    expect(page).to have_content("Insufficient Information to create a shelter.")

    fill_in :address, with: "2080 S. Quebec St."
    fill_in :name, with: "Dumb Friends League"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80231"
    click_button "Create Shelter"
    expect(current_path).to eq('/shelters/new')
    expect(page).to have_content("Insufficient Information to create a shelter.")

    fill_in :city, with: "Denver"
    fill_in :address, with: "2080 S. Quebec St."
    fill_in :name, with: "Dumb Friends League"
    fill_in :zip, with: "80231"
    click_button "Create Shelter"
    expect(current_path).to eq('/shelters/new')
    expect(page).to have_content("Insufficient Information to create a shelter.")

    fill_in :state, with: "CO"
    fill_in :city, with: "Denver"
    fill_in :address, with: "2080 S. Quebec St."
    fill_in :name, with: "Dumb Friends League"
    click_button "Create Shelter"
    expect(current_path).to eq('/shelters/new')
    expect(page).to have_content("Insufficient Information to create a shelter.")
  end

end
