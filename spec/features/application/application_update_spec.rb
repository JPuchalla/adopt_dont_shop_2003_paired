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

    PetApplication.create(pet_id: @sonic.id, adopt_application_id: @peter.id, approval: false)
    PetApplication.create(pet_id: @hobbes.id, adopt_application_id: @peter.id, approval: false)
  end

  it "can approve an application for a specific pet when clicked on" do
    visit "/applications/#{@peter.id}"
    within ".app-#{@sonic.id}" do
      click_button("Approve Application")
    end
    expect(current_path).to eq("/pets/#{@sonic.id}")
    expect(page).to have_content("pending")
    expect(page).to have_content("On hold for #{@peter.name}")
  end

  it "can approve an application for any number of pets" do
    visit "/applications/#{@peter.id}"
    click_button("Approve All Selected")
    expect(page).to have_content("You didn't select any pets.")
    expect(current_path).to eq("/applications/#{@peter.id}")

    within ".check-#{@hobbes.id}" do
      check "pet_ids_"
    end
    within ".check-#{@sonic.id}" do
      check "pet_ids_"
    end
    click_button("Approve All Selected")

    expect(current_path).to eq("/applications/#{@peter.id}")
    expect(page).to have_content("Application approved for all selections.")
    expect(Pet.find(@hobbes.id).adopt_status).to eq('pending')
    expect(Pet.find(@sonic.id).adopt_status).to eq('pending')
  end

  it "will only allow one approved application per pet" do
   john_jones = AdoptApplication.create(name: "John Jones",
                               address: "Mars St",
                               city: "Mars Capital",
                               state: "MS",
                               zip: "99999",
                               phone: "9991112233",
                               description: "Looking for an animal from a different planet.")

    PetApplication.create(pet_id: @sonic.id, adopt_application_id: john_jones.id, approval: false)
    visit "/applications/#{@peter.id}"
    within ".app-#{@sonic.id}" do
      click_button("Approve Application")
    end

    visit "/applications/#{john_jones.id}"
    within ".app-#{@sonic.id}" do
      expect(page).to_not have_button("Approve Application")
    end

    visit "/pets/#{@sonic.id}/applications"
    expect(page).to have_content("#{john_jones.name}")
    PetApplication.create(pet_id: @hobbes.id, adopt_application_id: john_jones.id, approval: false)
    visit "/applications/#{john_jones.id}"

    within ".check-#{@hobbes.id}" do
      check "pet_ids_"
    end

    within ".check-#{@sonic.id}" do
      check "pet_ids_"
    end

    click_button("Approve All Selected")
    expect(page).to have_content("A pet you selected is pending adoption elsewhere.")
    within ".check-#{@hobbes.id}" do
      check "pet_ids_"
    end

    click_button("Approve All Selected")
    expect(current_path).to eq("/applications/#{john_jones.id}")
    expect(page).to have_content("Application approved for all selections.")
    expect(Pet.find(@hobbes.id).adopt_status).to eq('pending')
    visit "/pets/#{@hobbes.id}"
    expect(page).to have_content("On hold for #{john_jones.name}")
  end
end
