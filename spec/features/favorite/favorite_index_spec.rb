require 'rails_helper'

RSpec.describe "Favorites index page", type: :feature do
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
                       shelter_id: @shelter_1.id,
                       favorite: true)

    @hobbes = Pet.create(image: "smug_cat.jpg",
                       name: "Hobbes",
                       description: "A very mischievous cat.",
                       approx_age: 5,
                       sex: "male",
                       adopt_status: 'adoptable',
                       shelter_id: @shelter_1.id,
                       favorite: false)
  end

  it "has an indicator showing the number of favorite pets" do
    visit "/shelters"
    expect(page).to have_content("Favorited Pets: 1")

    @cassidy.update(favorite: false)
    visit "/pets"
    expect(page).to have_content("Favorited Pets: 0")

  end

  it "can show user all favorites on index visit" do
    visit "/favorites"
    expect(page).to have_content(@cassidy.name)
    expect(page).to_not have_content(@hobbes.name)
  end

  it "shows a message saying no favorite pets" do
    @cassidy.update(favorite: false)
    visit "/favorites"
    expect(page).to_not have_content(@cassidy.name)
    expect(page).to_not have_content(@hobbes.name)
    expect(page).to have_content("You have no favorited pets.")
  end
end
