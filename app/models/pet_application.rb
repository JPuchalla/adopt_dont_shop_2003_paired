class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :adopt_application
end
