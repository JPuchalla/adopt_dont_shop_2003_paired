require 'rails_helper'

RSpec.describe "Pet update", type: :feature do
  before :each do
    shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")

    @pet_1 = Pet.create(image: "cute_dog.jpg",
                       name: "Cassidy",
                       description: "A very adorable pupper.",
                       approx_age: 10,
                       sex: "female",
                       adopt_status: 'adoptable',
                       shelter_id: shelter_1.id)

    visit "/pets/#{@pet_1.id}"
  end

  it "updates a pet" do
    click_button "Update Pet"
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

    fill_in :image, with: "smug_cat.jpg"
    fill_in :name, with: "Hobbes"
    fill_in :description, with: "A very mischievous cat."
    fill_in :approx_age, with: 5
    fill_in :sex, with: "male"
    click_button "Update Pet"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Hobbes")
    expect(page).to have_content("A very mischievous cat.")
    expect(page).to have_content(5)
    expect(page).to have_content("male")
  end

  it "has links to the shelter and pet indexes from pet edit page" do
    click_button "Update Pet"
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    click_on "Pet Index"
    expect(current_path).to eq("/pets")

    click_link "#{@pet_1.name}"
    click_button "Update Pet"
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    click_on "Shelter Index"
    expect(current_path).to eq("/shelters")
  end

  it "shows flash message for pet update when insufficient information is provided" do

    click_button "Update Pet"
    fill_in :name, with: nil
    click_button "Update Pet"
    expect(page).to have_content("Missing name to update a pet.")
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

    fill_in :image, with: nil
    click_button "Update Pet"
    expect(page).to have_content("Missing image to update a pet.")
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

    fill_in :description, with: nil
    click_button "Update Pet"
    expect(page).to have_content("Missing description to update a pet.")
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

    fill_in :approx_age, with: nil
    click_button "Update Pet"
    expect(page).to have_content("Missing approximate age to update a pet.")
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

    fill_in :sex, with: nil
    click_button "Update Pet"
    expect(page).to have_content("Missing sex to update a pet.")
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
  end

end
