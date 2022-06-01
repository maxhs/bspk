class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.integer :project_type, null: false ## intentionally leaving default nil
      t.references :organization
      t.references :user
      t.integer :max_tokens
      t.float :top_p
      t.float :temperature
      t.float :presence_penalty
      t.float :frequency_penalty
      t.timestamps
    end
  end
end
