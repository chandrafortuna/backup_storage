class Profile < ApplicationRecord

  validates :name, {uniqueness: true, presence: true}
  validates :paths,  presence: true

  has_many :profile_logs

end
