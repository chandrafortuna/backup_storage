class ProfileLogsController < ApplicationController
  before_action :set_profile_log, only: [:show, :edit, :update, :destroy]

  # GET /profile_logs
  # GET /profile_logs.json
  def index
    @profile_logs = ProfileLog.all
  end

  # GET /profile_logs/1
  # GET /profile_logs/1.json
  def show
  end

  # GET /profile_logs/new
  def new
    @profile_log = ProfileLog.new
  end

  # GET /profile_logs/1/edit
  def edit
  end

  # POST /profile_logs
  # POST /profile_logs.json
  def create
    @profile_log = ProfileLog.new(profile_log_params)

    respond_to do |format|
      if @profile_log.save
        format.html { redirect_to @profile_log, notice: 'Profile log was successfully created.' }
        format.json { render :show, status: :created, location: @profile_log }
      else
        format.html { render :new }
        format.json { render json: @profile_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_logs/1
  # PATCH/PUT /profile_logs/1.json
  def update
    respond_to do |format|
      if @profile_log.update(profile_log_params)
        format.html { redirect_to @profile_log, notice: 'Profile log was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_log }
      else
        format.html { render :edit }
        format.json { render json: @profile_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_logs/1
  # DELETE /profile_logs/1.json
  def destroy
    @profile_log.destroy
    respond_to do |format|
      format.html { redirect_to profile_logs_url, notice: 'Profile log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_log
      @profile_log = ProfileLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_log_params
      params.require(:profile_log).permit(:title, :path)
    end
end
