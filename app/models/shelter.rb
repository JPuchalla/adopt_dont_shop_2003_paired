class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets
  has_many :reviews

  def all_adoptable
    Pet.where("adopt_status = 'adoptable' AND shelter_id = '#{id}'")
  end

  def all_pending
    Pet.where("adopt_status = 'pending' AND shelter_id = '#{id}'")
  end
end
