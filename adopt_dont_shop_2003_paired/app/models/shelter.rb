class Shelter < ApplicationRecord
  validates_presence_of :name
  has_many :pets

  def all_adoptable
    pets.find_all{|pet| pet.is_adoptable?}
  end

  def all_pending
    pets.find_all{|pet| !pet.is_adoptable?}
  end
end
