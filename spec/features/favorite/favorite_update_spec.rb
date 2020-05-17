require 'rails_helper'

RSpec.describe "Marking pet as favorite", type: :feature do
  before :each do
    shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")

    @cassidy = Pet.create(image: "cute_dog.jpg",
                       name: "Cassidy",
                       description: "A very adorable pupper.",
                       approx_age: 10,
                       sex: "female",
                       adopt_status: 'adoptable',
                       shelter_id: shelter_1.id)

    visit "/pets/#{@cassidy.id}"
  end

  it "can favorite a pet" do
    expect(page).to have_content("Favorited Pets: 0")
    click_button "Favorite Pet"

    expect(current_path).to eq("/pets/#{@cassidy.id}")
    expect(page).to have_content("You have favorited #{@cassidy.name}.")
    expect(page).to have_content("Favorited Pets: 1")
  end

end
