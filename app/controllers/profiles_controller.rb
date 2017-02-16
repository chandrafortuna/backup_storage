class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def create
  end

  def backup
  end
end
