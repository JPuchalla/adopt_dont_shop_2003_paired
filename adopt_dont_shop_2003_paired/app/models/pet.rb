class Pet < ApplicationRecord
  validates_presence_of :name
  belongs_to :shelter

  def self.number_pets
    count
  end

  def is_adoptable?
    adopt_status == "adoptable"
  end
end
