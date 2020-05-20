class AdoptApplication < ApplicationRecord
  validates_presence_of :name, :address, :city, :state,
                        :zip, :phone, :description
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def is_approved_for_pet?(pet_id)
    pet_applications.find_by(pet_id: pet_id).approval
  end
end
