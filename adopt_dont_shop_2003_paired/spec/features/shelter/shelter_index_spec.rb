require 'rails_helper'

RSpec.describe "Shelter index page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")

    @shelter_2 = Shelter.create(name: "Denver Animal Shelter",
                               address: "1241 W. Bayaud Ave.",
                               city: "Denver",
                               state: "CO",
                               zip: "80223")

    visit "/shelters"
  end

  it "shows user all shelters on index visit" do
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end

  it "has an edit link for each shelter on the index" do
    click_button "Edit #{@shelter_1.name}"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
  end

  it "has a delete link for each shelter on the index" do
    click_button "Delete #{@shelter_2.name}"
    expect(page).to have_content(@shelter_1.name)
    expect(page).to_not have_content(@shelter_2.name)
  end

  it "has a link for each shelter in their name" do
    click_link "#{@shelter_1.name}"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    visit "/shelters"
    click_link "#{@shelter_2.name}"
    expect(current_path).to eq("/shelters/#{@shelter_2.id}")
  end

  it "has links to the shelter and pet indexes from shelter index page" do
    click_on "Pet Index"
    expect(current_path).to eq("/pets")
    click_on "Shelter Index"

    expect(current_path).to eq("/shelters")
    click_on "Shelter Index"
    expect(current_path).to eq("/shelters")
  end

  it "can sort the index alphabetically" do
    expect(page.body.index(@shelter_1.name)).to be < page.body.index(@shelter_2.name)
    click_on "Sort Alphabetically"
    expect(page.body.index(@shelter_2.name)).to be < page.body.index(@shelter_1.name)
  end

  it "can sort the index by number of pets" do
    Pet.create(image: "cute_dog.jpg",
               name: "Cassidy",
               description: "A very adorable pupper.",
               approx_age: 10,
               sex: "female",
               adopt_status: 'pending',
               shelter_id: @shelter_2.id)
    expect(page.body.index(@shelter_1.name)).to be < page.body.index(@shelter_2.name)
    click_on "Sort by Number of Pets"
    expect(page.body.index(@shelter_2.name)).to be < page.body.index(@shelter_1.name)
  end
end
