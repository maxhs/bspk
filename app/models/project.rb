class Project < ApplicationRecord
	belongs_to :organization, optional: true
	has_many :trainings

	enum :project_type, {
		naming: 			1,
		tagline: 			2,
		description: 	3,
		caption: 			4,
		ad_copy: 			5,
		web_copy: 		6
	}, suffix: true, scopes: true

end
