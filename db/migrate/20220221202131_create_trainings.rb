class CreateTrainings < ActiveRecord::Migration[7.0]
  def change
    create_table :trainings do |t|
      t.references :project
      t.datetime :uploaded_at
      t.datetime :trained_at
      t.text :uploaded_file_id
      t.text :fine_tune_id
      t.timestamps
    end
  end
end
