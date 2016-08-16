class CreateDataFiles < ActiveRecord::Migration
  def change
    create_table :data_files do |t|
      t.string  :name
      t.integer :size
      t.text    :text
      t.integer :folder_id

      t.timestamps null: false
    end
  end
end
