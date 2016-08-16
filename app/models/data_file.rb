class DataFile < ActiveRecord::Base
  belongs_to :folder
  before_save :change_size

  def change_size
    self.size = self.name.length + self.text.length
  end
end
