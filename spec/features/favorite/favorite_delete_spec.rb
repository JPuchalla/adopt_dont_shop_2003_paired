require 'rails_helper'

RSpec.describe "can delete and update favorites count", type: :feature do
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
                       adopt_status: 'adoptable',
                       shelter_id: @shelter_1.id)

    @hobbes = Pet.create(image: "smug_cat.jpg",
                       name: "Hobbes",
                       description: "A very mischievous cat.",
                       approx_age: 5,
                       sex: "male",
                       adopt_status: 'adoptable',
                       shelter_id: @shelter_1.id)

  end

  it "can delete favorite and update pets show page." do
    visit "/pets/#{@cassidy.id}"
    click_button "Favorite Pet"
    expect(page).to have_content("Favorited Pets: 1")
    expect(page).to_not have_button("Favorite Pet")
    click_button "Remove Favorite"
    expect(page).to have_content("Removed #{@cassidy.name} from favorites.")
    expect(current_path).to eq "/pets/#{@cassidy.id}"
    expect(page).to have_button("Favorite Pet")
    expect(page).to_not have_button("Remove Favorite")
    expect(page).to have_content("Favorited Pets: 0")
  end

  it "remove favorite from index page." do
    visit "/pets/#{@cassidy.id}"
    click_button "Favorite Pet"
    visit "/pets/#{@hobbes.id}"
    click_button "Favorite Pet"
    visit '/favorites'
    expect(page).to have_content("Favorited Pets: 2")
    within(".favorite-#{@cassidy.id}") do
      click_button "Remove Favorite"
    end
    expect(page).to have_content("Removed #{@cassidy.name} from favorites.")
    expect(current_path).to eq "/favorites"
    expect(page).to_not have_css (".favorite-#{@cassidy.id}")
    expect(page).to have_content(@hobbes.name)
    expect(page).to have_content("Favorited Pets: 1")
  end

  it "can remove all favorites from the index page at once" do
    visit "/pets/#{@cassidy.id}"
    click_button "Favorite Pet"
    visit "/pets/#{@hobbes.id}"
    click_button "Favorite Pet"
    visit '/favorites'
    expect(page).to have_content("Favorited Pets: 2")
    click_button "Remove All Favorites"
    expect(current_path).to eq "/favorites"
    expect(page).to_not have_content(@cassidy.name)
    expect(page).to_not have_content(@hobbes.name)
    expect(page).to have_content("You have no favorited pets.")
    expect(page).to have_content("Favorited Pets: 0")
  end
end
