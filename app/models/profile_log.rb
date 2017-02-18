class ProfileLog < ApplicationRecord
  belongs_to :profile

  def self.resolve_log_by_profile(profile_id)
    where(:profile_id => profile_id).order("created_at desc")
  end
end
