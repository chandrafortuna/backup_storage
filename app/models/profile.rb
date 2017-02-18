class Profile < ApplicationRecord

  validates :name, {uniqueness: true, presence: true}
  validates :paths,  presence: true

  has_many :profile_logs, -> { order(created_at: :desc) }

  def self.resolve_by_created(user_id)
    where(:user_id => user_id).order(created_at: :desc)
  end

end
