require 'rails_helper'

RSpec.describe "Shelter reivew create page.", type: :feature do
  it "It creates a review for a shelter" do
    shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")

     visit "/shelters/#{shelter_1.id}"

     click_button "Add Review"
     expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
     fill_in :title, with: "Awesome Place"
     fill_in :rating, with: 5
     fill_in :content, with: "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!"
     click_button "Add Review"

     expect(current_path).to eq("/shelters/#{shelter_1.id}")
     new_review = Review.last
     expect(new_review.title).to eq("Awesome Place")
     expect(new_review.rating).to eq(5)
     expect(new_review.content).to eq("Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!")

     expect(new_review.image).to eq(nil)
     expect(page).to have_content (new_review.title)
     expect(page).to have_content (new_review.rating)
     expect(page).to have_content (new_review.content)
   end
 end
