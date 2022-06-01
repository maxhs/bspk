class OrganizationUser < ApplicationRecord
	belongs_to :user
	belongs_to :organization

	enum :role, {
		none: 0,
		owner: 1,
		admin: 2,
		normal: 3
	}
end
