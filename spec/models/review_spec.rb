require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title
         should validate_presence_of :rating
         should validate_presence_of :content }
    it "should not have a rating of more than 5" do
      shelter_1 = Shelter.create(name: "Dumb Friends League",
                                 address: "2080 S. Quebec St.",
                                 city: "Denver",
                                 state: "CO",
                                 zip: "80231")

      new_review = Review.new(title: "Awesome place!",
                              rating: 6,
                              content: "Truly enjoyed our time working with this shelter. Staff was great, and we found our perfect pet!",
                              image: nil,
                              shelter_id: shelter_1.id)

      expect(new_review.save).to eq(false)
    end
  end
  describe "relationships" do
    it { should belong_to :shelter}
  end
end
