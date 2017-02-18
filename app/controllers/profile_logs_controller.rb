class ProfileLogsController < ApplicationController
  before_action :authenticate_user!

  # GET /profile_logs
  # GET /profile_logs.json
  def index
    @profile = Profile.find(params[:profile_id])
    @profile_log = ProfileLog.new
  end

  def detail
    @profile = Profile.find(params[:profile_id])
    log = @profile.profile_logs.find(params[:profile_log_id])
    rsync = Rsync.new
    result = log.nil? ? '' : rsync.find_directory(log.path)
    respond_to do |format|
      format.json { render json: result }
    end

  end

end
