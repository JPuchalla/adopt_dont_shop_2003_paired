require "rails_helper"

RSpec.describe "pet applications index", type: :feature do
  before :each do
    @francis = AdoptApplication.create(name: "Francis",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231",
                               phone: "2023332291",
                               description: "I am a perfect human.")
    @peter_pan = AdoptApplication.create(name: "Peter Pan",
                               address: "Mars St",
                               city: "Mars Capital",
                               state: "MS",
                               zip: "99999",
                               phone: "9991112233",
                               description: "Looking for an animal from a different planet.")

    @shelter_1 = Shelter.create(name: "Dumb Friends League",
                              address: "2080 S. Quebec St.",
                              city: "Denver",
                              state: "CO",
                              zip: "80231")

    @hobbes = Pet.create(image: "smug_cat.jpg",
                       name: "Hobbes",
                       description: "A very mischievous cat.",
                       approx_age: 5,
                       sex: "male",
                       adopt_status: 'adoptable',
                       shelter_id: @shelter_1.id)
  end

  it "shows all applicants on a pet shop page" do
    PetApplication.create(pet_id: @hobbes.id, adopt_application_id: @francis.id, approval: false)
    PetApplication.create(pet_id: @hobbes.id, adopt_application_id: @peter_pan.id, approval: false)

    visit "/pets/#{@hobbes.id}"
    click_button "All Applications"
    expect(current_path).to eq("/pets/#{@hobbes.id}/applications")
    expect(page).to have_link("#{@francis.name}")
    expect(page).to have_link("#{@peter_pan.name}")
  end

  it "shows a message if there are no applications" do
    visit "/pets/#{@hobbes.id}"
    click_button "All Applications"
    expect(current_path).to eq("/pets/#{@hobbes.id}/applications")
    expect(page).to have_content("There are no applications yet.")
  end

  it "shows pets with applications separate from pets without" do
    PetApplication.create(pet_id: @hobbes.id, adopt_application_id: @francis.id, approval: false)
    PetApplication.create(pet_id: @hobbes.id, adopt_application_id: @peter_pan.id, approval: false)
    sonic = Pet.create(image: "small_hedgehog.jpg",
                       name: "Sonic",
                       description: "A small hedgehog.",
                       approx_age: 2,
                       sex: "male",
                       adopt_status: 'adoptable',
                       shelter_id: @shelter_1.id)
    visit "/pets/#{@hobbes.id}"
    click_button "Favorite Pet"
    visit "/pets/#{sonic.id}"
    click_button "Favorite Pet"

    visit "/favorites"
    within ".have-application" do
      expect(page).to have_link("#{@hobbes.name}")
    end
    within ".no-application" do
      expect(page).to have_link("#{sonic.name}")
    end
  end

end
