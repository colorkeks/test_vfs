class Folder < ActiveRecord::Base
  acts_as_nested_set

  has_many :data_files, dependent: :destroy
  before_destroy :check_root

  # на всякий случай
  def check_root
    if Folder.root.id.equal?(id)
      # errors.add(:folder, 'Нельзя удалить root директорию')
      false
    end
  end
end
