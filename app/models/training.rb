class Training < ApplicationRecord
  belongs_to :project
  has_one_attached :file
end
