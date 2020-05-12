require 'rails_helper'

RSpec.describe "Shelter reivew update page.", type: :feature do
  it "It update a review for a shelter" do
    shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")
   review_1 = Review.create(title: "Found the one",
                             rating: 4,
                             content: "It took us a bit of time, but we found that special little guy to bring home to the kids!",
                             image: nil,
                             shelter_id: shelter_1.id)

   visit "/shelters/#{shelter_1.id}"

   click_button "Edit Review"
   expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")
   fill_in :title, with: "Awesome Place"
   fill_in :rating, with: 5
   fill_in :content, with: "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!"
   click_button "Edit Review"

   expect(current_path).to eq("/shelters/#{shelter_1.id}")

   title_edit = "Awesome Place"
   rating_edit = 5
   content_edit = "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!"

   expect(page).to have_content (title_edit)
   expect(page).to have_content (rating_edit)
   expect(page).to have_content (content_edit)

  end
end
