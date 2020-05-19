require "rails_helper"

RSpec.describe "Revoking approval", type: :feature do
  it "can revoke approval from an application" do
    peter = AdoptApplication.create(name: "Peter",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231",
                               phone: "2023332291",
                               description: "I am a perfect human.")

    shelter_1 = Shelter.create(name: "Dumb Friends League",
                              address: "2080 S. Quebec St.",
                              city: "Denver",
                              state: "CO",
                              zip: "80231")

    hobbes = Pet.create(image: "smug_cat.jpg",
                       name: "Hobbes",
                       description: "A very mischievous cat.",
                       approx_age: 5,
                       sex: "male",
                       adopt_status: 'pending',
                       shelter_id: shelter_1.id)

    sonic = Pet.create(image: "small_hedgehog.jpg",
                      name: "Sonic",
                      description: "A small hedgehog.",
                      approx_age: 2,
                      sex: "male",
                      adopt_status: 'adoptable',
                      shelter_id: shelter_1.id)

    PetApplication.create(pet_id: sonic.id, adopt_application_id: peter.id, approval: false)
    PetApplication.create(pet_id: hobbes.id, adopt_application_id: peter.id, approval: true)

    visit "/applications/#{peter.id}"

    within ".app-#{sonic.id}" do
      expect(page).to have_button "Approve Application"
      expect(page).to_not have_button "Revoke Approval"
    end

    within ".app-#{hobbes.id}" do
      expect(page).to_not have_button "Approve Application"
      click_button "Revoke Approval"
    end

    expect(current_path).to eq("/applications/#{peter.id}")

    within ".app-#{hobbes.id}" do
      expect(page).to have_button "Approve Application"
      expect(page).to_not have_button "Revoke Approval"
    end

    visit "/pets/#{hobbes.id}"
    expect(page).to have_content("#{hobbes.name} is adoptable.")
    expect(page).to_not have_content(peter.id)
  end
end
