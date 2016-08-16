class Folder < ActiveRecord::Base
  acts_as_nested_set

  has_many :data_files, dependent: :destroy
end
