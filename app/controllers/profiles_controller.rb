class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :update, :destroy]
  def index
    @profile = Profile.new
    @profiles = Profile.resolve_by_created(current_user.id)
  end

  def show

  end

  def create
    @profile = Profile.new(profile_params) do |e|
      e.user_id = current_user.id
    end
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
    profile_slug = @profile.name.parameterize
    log = DateTime.now.strftime('%Y-%m-%d-%H-%M-%S')
    rsync.backup(current_user.id, profile_slug, log, paths, excludes)
    @profile.profile_logs.build({:title => log, :path => "#{current_user.id}/#{profile_slug}/#{log}"})
    @profile.save
    redirect_to profile_profile_logs_path(@profile.id)
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
