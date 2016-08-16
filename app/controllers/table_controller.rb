class TableController < ApplicationController
  def index
    # root =  Folder.create!(name: 'root')
    # new = Folder.create!(name: 'some_folder')
    # new.move_to_child_of(root)
    # DataFile.create!(name: 'new_file', folder_id: 2)
    @root = Folder.root
    @folders = Folder.all
  end
end
