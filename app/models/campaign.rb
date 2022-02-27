class Campaign < ApplicationRecord
	belongs_to :organization, optional: true
	has_many :trainings
end
