class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_profile, only: [:show, :update, :destroy]
  def index
    @profile = Profile.new
    @profiles = Profile.all
  end

  def show

  end

  def create
    @profile = Profile.new(profile_params)
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile }
        # added:
        format.js   { render action: 'show', status: :created, location: @profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        @updated = true
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @profile }
        # added:
        format.js   { render action: 'show', status: :created, location: @profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def backup
    @profile = Profile.find(params[:profile_id])
    rsync = Rsync.new
    excludes = text_to_array(@profile.excludes)
    paths = text_to_array(@profile.paths)
    rsync.backup(current_user.id, @profile.name.parameterize, paths, excludes)
  end

  def detail
    @profile = Profile.find_by_id(params[:profile_id])
    respond_to do |format|
      format.json { render json: @profile }
    end
  end

  private
  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :paths, :excludes)
  end

  def text_to_array(str)
    str.split("\r\n")
  end
end
