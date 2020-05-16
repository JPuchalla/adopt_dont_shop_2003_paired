require 'rails_helper'

RSpec.describe "Applying for adoption", type: :feature do
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
  end

  it "can create an application for a favorited pet" do
    hobbes = Pet.create(image: "smug_cat.jpg",
                        name: "Hobbes",
                        description: "A very mischievous cat.",
                        approx_age: 5,
                        sex: "male",
                        adopt_status: 'adoptable',
                        shelter_id: @shelter_1.id)

    sonic = Pet.create(image: "small_hedgehog.jpg",
                       name: "Sonic",
                       description: "A small hedgehog.",
                       approx_age: 2,
                       sex: "male",
                       adopt_status: 'adoptable',
                       shelter_id: @shelter_1.id)

    visit "/pets/#{@cassidy.id}"
    click_button "Favorite Pet"
    visit "/pets/#{hobbes.id}"
    click_button "Favorite Pet"
    visit "/pets/#{sonic.id}"
    click_button "Favorite Pet"
    visit "/favorites"
    click_button "Apply for Adoption"
    expect(current_path).to eq ("/applications/new")
    within (".checkbox-#{@cassidy.id}") do
      check("pet_ids_")
    end
    within (".checkbox-#{hobbes.id}") do
      check("pet_ids_")
    end
    expect(page).to have_css(".checkbox-#{sonic.id}")

    fill_in :name, with: "John Doe"
    fill_in :address, with: "1500 Colfax Ave"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80230"
    fill_in :phone, with: "(303) 867-5309"
    fill_in :description, with: "I've got a a pet friendly place with room for a dog and a cat and I love them"
    click_button "Submit Application"

    expect(page).to have_content("Application submitted!")
    expect(current_path).to eq("/favorites")
    expect(page).to_not have_content("#{@cassidy.name}")
    expect(page).to_not have_content("#{hobbes.name}")
    expect(page).to have_content("#{sonic.name}")
  end

  it "notifies user of an incomplete form" do
    visit "/pets/#{@cassidy.id}"
    click_button "Favorite Pet"
    visit "/favorites"
    click_button "Apply for Adoption"

    fill_in :name, with: "John Doe"
    fill_in :address, with: "1500 Colfax Ave"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80230"
    fill_in :phone, with: "(303) 867-5309"
    fill_in :description, with: "I've got a a pet friendly place with room for a dog and a cat and I love them"
    click_button "Submit Application"

    expect(page).to have_content("Submission failed, please fill out all fields")
    expect(current_path).to eq("/applications/new")

    check("pet_ids_")
    fill_in :address, with: "1500 Colfax Ave"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80230"
    fill_in :phone, with: "(303) 867-5309"
    fill_in :description, with: "I've got a a pet friendly place with room for a dog and a cat and I love them"
    click_button "Submit Application"

    expect(page).to have_content("Submission failed, please fill out all fields")
    expect(current_path).to eq("/applications/new")

    check("pet_ids_")
    fill_in :name, with: "John Doe"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80230"
    fill_in :phone, with: "(303) 867-5309"
    fill_in :description, with: "I've got a a pet friendly place with room for a dog and a cat and I love them"
    click_button "Submit Application"

    expect(page).to have_content("Submission failed, please fill out all fields")
    expect(current_path).to eq("/applications/new")

    check("pet_ids_")
    fill_in :name, with: "John Doe"
    fill_in :address, with: "1500 Colfax Ave"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80230"
    fill_in :phone, with: "(303) 867-5309"
    fill_in :description, with: "I've got a a pet friendly place with room for a dog and a cat and I love them"
    click_button "Submit Application"

    expect(page).to have_content("Submission failed, please fill out all fields")
    expect(current_path).to eq("/applications/new")

    check("pet_ids_")
    fill_in :name, with: "John Doe"
    fill_in :address, with: "1500 Colfax Ave"
    fill_in :city, with: "Denver"
    fill_in :zip, with: "80230"
    fill_in :phone, with: "(303) 867-5309"
    fill_in :description, with: "I've got a a pet friendly place with room for a dog and a cat and I love them"
    click_button "Submit Application"

    expect(page).to have_content("Submission failed, please fill out all fields")
    expect(current_path).to eq("/applications/new")

    check("pet_ids_")
    fill_in :name, with: "John Doe"
    fill_in :address, with: "1500 Colfax Ave"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :phone, with: "(303) 867-5309"
    fill_in :description, with: "I've got a a pet friendly place with room for a dog and a cat and I love them"
    click_button "Submit Application"

    expect(page).to have_content("Submission failed, please fill out all fields")
    expect(current_path).to eq("/applications/new")

    check("pet_ids_")
    fill_in :name, with: "John Doe"
    fill_in :address, with: "1500 Colfax Ave"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80230"
    fill_in :description, with: "I've got a a pet friendly place with room for a dog and a cat and I love them"
    click_button "Submit Application"

    expect(page).to have_content("Submission failed, please fill out all fields")
    expect(current_path).to eq("/applications/new")

    check("pet_ids_")
    fill_in :name, with: "John Doe"
    fill_in :address, with: "1500 Colfax Ave"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80230"
    fill_in :phone, with: "(303) 867-5309"

    expect(page).to have_content("Submission failed, please fill out all fields")
    expect(current_path).to eq("/applications/new")

    check("pet_ids_")
    fill_in :name, with: "John Doe"
    fill_in :address, with: "1500 Colfax Ave"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80230"
    fill_in :phone, with: "(303) 867-5309"
    fill_in :description, with: "I've got a a pet friendly place with room for a dog and a cat and I love them"
    click_button "Submit Application"

    expect(page).to have_content("Application submitted!")
  end
end
