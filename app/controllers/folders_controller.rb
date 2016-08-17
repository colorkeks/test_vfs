class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  # GET /folders/1
  # GET /folders/1.json
  def show
    @root_id = Folder.root.id
    @size = @folder.deep_size
    respond_window_with @folder
  end

  # GET /folders/new
  def new
    @folder = Folder.new(params[:folder].nil? ? nil : folder_params )
    respond_modal_with @folder
  end

  # GET /folders/1/edit
  def edit
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.create(folder_params)
    respond_window_with @folder, :location => :back
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    @folder.update(folder_params)
    respond_window_with @folder, :location => :back
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder.destroy
    respond_window_with @folder, :location => :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :size, :parent_id)
    end
end
