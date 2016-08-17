class Folder < ActiveRecord::Base
  acts_as_nested_set

  has_many :data_files, dependent: :destroy
  before_save :change_size
  before_destroy :check_root

  # на всякий случай
  def check_root
    if Folder.root.id.equal?(id)
      # errors.add(:folder, 'Нельзя удалить root директорию')
      false
    end
  end

  def change_size
    self.size = self.name.length
  end

  def deep_size
    # TODO REFACTOR
    folders = self.self_and_descendants
    # взяли веса всех папок 'наследников' и сложили
    size = folders.collect {|h| h[:size] }.inject(:+)
    # складываем веса всех файлов для каждой из папок 'наследников'
    folders.each do |folder|
      size += folder.data_files.collect{|h| h[:size] }.inject(:+) || 0
    end

    size
  end
end
