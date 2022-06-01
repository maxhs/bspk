class CreateOrganizationUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_users do |t|
      t.references :organization
      t.references :user
      t.integer :role, default: 0, null: false
      t.timestamps
    end
  end
end
