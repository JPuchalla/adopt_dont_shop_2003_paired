require "rails_helper"

RSpec.describe "Approving an Application", type: :feature do
  before :each do
    @peter = AdoptApplication.create(name: "Peter",
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

    PetApplication.create(pet_id: @sonic.id, adopt_application_id: @peter.id)
  end

  it "can approve an application for a specific pet when clicked on" do
    visit "/applications/#{@peter.id}"
    within ".app-#{@sonic.id}" do click_button("Approve Application")
      end
    expect(current_path).to eq("/pets/#{@sonic.id}")
    expect(page).to have_content("pending")
    expect(page).to have_content("On hold for #{@peter.name}")

  end
end
