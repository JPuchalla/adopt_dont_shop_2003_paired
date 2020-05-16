require 'rails_helper'

RSpec.describe "Marking pet as favorite", type: :feature do
  it "can create an application for a favorited pet" do
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
                       adopt_status: 'adoptable',
                       shelter_id: shelter_1.id)

    hobbes = Pet.create(image: "smug_cat.jpg",
                        name: "Hobbes",
                        description: "A very mischievous cat.",
                        approx_age: 5,
                        sex: "male",
                        adopt_status: 'adoptable',
                        shelter_id: shelter_1.id)

    sonic = Pet.create(image: "small_hedgehog.jpg",
                       name: "Sonic",
                       description: "A small hedgehog.",
                       approx_age: 2,
                       sex: "male",
                       adopt_status: 'adoptable',
                       shelter_id: shelter_1.id)

    visit "/pets/#{cassidy.id}"
    click_button "Favorite Pet"
    visit "/pets/#{hobbes.id}"
    click_button "Favorite Pet"
    visit "/pets/#{sonic.id}"
    click_button "Favorite Pet"
    visit "/favorites"
    click_button "Apply for Adoption"
    expect(current_path).to eq ("/applications/new")
    check("checkbox-#{cassidy.id}")
    check("checkbox-#{hobbes.id}")
    expect(page).to have_css("checkbox-#{sonic.id}")

    fill_in :name, with: "John Doe"
    fill_in :address, with: "1500 Colfax Ave"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80230
    fill_in :phone_number, with: "(303) 867-5309"
    fill_in :description, with: "I've got a a pet friendly place with room for a dog and a cat and I love them"
    click_button "Submit Application"

    expect(page).to have_content("Application submitted!")
    expect(current_path).to eq("/favorites")
    expect(page).to_not have_content("#{cassidy.name}")
    expect(page).to_not have_content("#{hobbes.name}")
    expect(page).to have_content("#{sonic.name}")
  end
end
