require 'rails_helper'

RSpec.describe "Delete pet", type: :feature do
  it "deletes a pet" do
    shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")

    cassidy = Pet.create(image: "cute_dog.jpg",
                       name: "Cassidy",
                       description: "A very adorable pupper.",
                       approx_age: 10,
                       sex: "female",
                       adopt_status: 'pending',
                       shelter_id: shelter_1.id)

    hobbes = Pet.create(image: "smug_cat.jpg",
                       name: "Hobbes",
                       description: "A very mischievous cat.",
                       approx_age: 5,
                       sex: "male",
                       adopt_status: 'adoptable',
                       shelter_id: shelter_1.id)

    visit '/pets'
    expect(page).to have_content(cassidy.name)
    expect(page).to have_content(hobbes.name)

    visit "/pets/#{hobbes.id}"
    click_button "Delete Pet"
    expect(current_path).to eq("/pets")

    expect(page).to have_content(cassidy.name)
    expect(page).to_not have_content(hobbes.name)
  end
end
