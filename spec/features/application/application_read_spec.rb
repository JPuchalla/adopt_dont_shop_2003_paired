require "rails_helper"

RSpec.describe "Visiting applications show page", type: :feature do
  before :each do
    @application_1 = AdoptApplication.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231",
                               phone: "2023332291",
                               description: "I am a perfect human.")

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

    @sonic = Pet.create(image: "small_hedgehog.jpg",
                      name: "Sonic",
                      description: "A small hedgehog.",
                      approx_age: 2,
                      sex: "male",
                      adopt_status: 'adoptable',
                      shelter_id: @shelter_1.id)

    PetApplication.create(pet_id: @hobbes.id, adopt_application_id: @application_1.id, approval: false)
    PetApplication.create(pet_id: @sonic.id, adopt_application_id: @application_1.id, approval: false)
  end

  it "user sees the application show page" do

    visit "/applications/#{@application_1.id}"
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip)
    expect(page).to have_content(@application_1.phone)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_link("#{@hobbes.name}")
    expect(page).to have_link("#{@sonic.name}")

  end
end
