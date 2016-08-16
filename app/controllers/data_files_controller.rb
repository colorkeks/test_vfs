class DataFilesController < ApplicationController
  before_action :set_data_file, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  # GET /data_files/1
  # GET /data_files/1.json
  def show
    respond_window_with @data_file
  end

  # GET /data_files/new
  def new
    @data_file = DataFile.new(params[:data_file].nil? ? nil : data_file_params )
    respond_modal_with @data_file
  end

  # POST /data_files
  # POST /data_files.json
  def create
    @data_file = DataFile.create(data_file_params)
    respond_window_with @data_file, :location => :back
  end

  # PATCH/PUT /data_files/1
  # PATCH/PUT /data_files/1.json
  def update
    @data_file.update(data_file_params)
    respond_window_with @data_file, :location => :back
  end

  # DELETE /data_files/1
  # DELETE /data_files/1.json
  def destroy
    @data_file.destroy
    respond_window_with @data_file, :location => :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_file
      @data_file = DataFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_file_params
      params.require(:data_file).permit(:name, :size, :text, :folder_id)
    end
end
