class AdoptApplication < ApplicationRecord
  validates_presence_of :name, :address, :city, :state,
                        :zip, :phone, :description
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def apply_for_pet(pet_id)
      PetApplication.create(pet_id: pet_id, adopt_application_id: id)
  end
end
