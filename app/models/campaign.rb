class Campaign < ApplicationRecord
	belongs_to :organization, optional: true
	has_many_attached :training_sets
end
