class Training < ApplicationRecord
  belongs_to :campaign
  has_one_attached :file
end
