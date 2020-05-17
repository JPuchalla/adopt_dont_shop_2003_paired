require 'rails_helper'

RSpec.describe "Pet read page", type: :feature do
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

  it "shows user pet info on page visit" do
    expect(page).to have_content(@cassidy.name)
    expect(page).to have_content(@cassidy.description)
    expect(page).to have_content(@cassidy.approx_age)
    expect(page).to have_content(@cassidy.sex)
    expect(page).to have_content(@cassidy.adopt_status)
  end

  it "has links to the shelter and pet indexes from pet info page" do
    click_on "Pet Index"
    expect(current_path).to eq("/pets")

    click_link "#{@cassidy.name}"
    expect(current_path).to eq("/pets/#{@cassidy.id}")
    click_on "Shelter Index"
    expect(current_path).to eq("/shelters")
  end

end
