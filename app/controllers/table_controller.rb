class TableController < ApplicationController
  def index
    @root = Folder.root
    @folders = Folder.all
  end
end
