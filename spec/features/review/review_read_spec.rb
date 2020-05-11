require 'rails_helper'

RSpec.describe "Shelter review page", type: :feature do
  it "shows all reviews of shelter on page visit" do
    shelter_1 = Shelter.create(name: "Dumb Friends League",
                               address: "2080 S. Quebec St.",
                               city: "Denver",
                               state: "CO",
                               zip: "80231")

    review_1 = Review.create(title: "Awesome place!",
                              rating: 5,
                              content: "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!",
                              image: nil,
                              shelter_id: shelter_1.id)

    review_2 = Review.create(title: "Found the one",
                              rating: 4,
                              content: "It took us a bit of time, but we found that special little guy to bring home to the kids!",
                              image: nil,
                              shelter_id: shelter_1.id)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.rating)
    expect(page).to have_content(review_1.content)
    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_2.rating)
    expect(page).to have_content(review_2.content)

  end

end
