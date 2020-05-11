require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title
         should validate_presence_of :rating
         should validate_presence_of :content }
  end
  describe "relationships" do
    it { should belong_to :shelter}
  end
end
