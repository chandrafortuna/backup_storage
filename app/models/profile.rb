class Profile < ApplicationRecord
  validates :name, {uniqueness: true, presence: true}

end
