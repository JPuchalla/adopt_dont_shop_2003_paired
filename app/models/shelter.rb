class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets
  has_many :reviews
  has_many :pet_applications, through: :pets

  def all_adoptable
    Pet.where("adopt_status = 'adoptable' AND shelter_id = '#{id}'")
  end

  def all_pending
    Pet.where("adopt_status = 'pending' AND shelter_id = '#{id}'")
  end

  def count_of_pets
    pets.count
  end

  def avg_review_rating
    reviews.average(:rating)
  end

  def count_of_apps
    pet_applications.select(:adopt_application_id).distinct.count
  end
end
