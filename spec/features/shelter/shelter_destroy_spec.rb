require 'rails_helper'

RSpec.describe "Delete shelter", type: :feature do
  it "deletes a shelter" do
    shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")

    shelter_2 = Shelter.create(name: "Denver Animal Shelter",
                               address: "1241 W. Bayaud Ave.",
                               city: "Denver",
                               state: "CO",
                               zip: "80223")

    visit '/shelters'
    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)

    visit "/shelters/#{shelter_2.id}"
    click_button "Delete Shelter"
    expect(current_path).to eq("/shelters")

    expect(page).to have_content(shelter_1.name)
    expect(page).to_not have_content(shelter_2.name)
  end
end
