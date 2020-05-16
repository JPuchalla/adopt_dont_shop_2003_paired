require 'rails_helper'

describe AdoptApplication, type: :model do
  describe "validations" do
    it { should validate_presence_of :name
         should validate_presence_of :address
         should validate_presence_of :city
         should validate_presence_of :state
         should validate_presence_of :zip
         should validate_presence_of :phone
         should validate_presence_of :description }
  end
  describe "relationships" do
    it { should have_many :pet_applications}
    it { should have_many(:pets).through(:pet_applications)}
  end
end
