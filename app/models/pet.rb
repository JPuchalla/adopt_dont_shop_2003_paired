class Pet < ApplicationRecord
  validates_presence_of :name, :image, :description, :approx_age, :sex
  belongs_to :shelter
  has_many :pet_applications
  has_many :adopt_applications, through: :pet_applications

  def self.number_pets
    count
  end

  def is_adoptable?
    adopt_status == "adoptable"
  end
end
