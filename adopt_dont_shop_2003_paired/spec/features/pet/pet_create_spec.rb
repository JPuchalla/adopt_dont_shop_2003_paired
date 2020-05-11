require 'rails_helper'

RSpec.describe "Create pet page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")
    visit "/shelters/#{@shelter_1.id}/pets"
  end

  it "creates a new adoptable pet at a shelter" do
    click_button "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
    fill_in :image, with: "cute_dog.jpg"
    fill_in :name, with: "Cassidy"
    fill_in :description, with: "A very adorable pupper."
    fill_in :approx_age, with: 10
    fill_in :sex, with: "female"
    click_button "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
    new_pet = Pet.last
    expect(new_pet.image).to eq("cute_dog.jpg")
    expect(new_pet.name).to eq("Cassidy")
    expect(new_pet.description).to eq("A very adorable pupper.")
    expect(new_pet.approx_age).to eq(10)
    expect(new_pet.sex).to eq("female")
    expect(new_pet.adopt_status).to eq("adoptable")
    expect(page).to have_content (new_pet.name)
    expect(page).to have_content (new_pet.approx_age)
    expect(page).to have_content (new_pet.sex)
  end

  it "has links to the shelter and pet indexes from pet create page" do
    click_button "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
    click_on "Shelter Index"
    expect(current_path).to eq("/shelters")
    click_link "#{@shelter_1.name}"
    click_button "Available Pets"
    click_button "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
    click_on "Pet Index"
    expect(current_path).to eq("/pets")
  end

end
