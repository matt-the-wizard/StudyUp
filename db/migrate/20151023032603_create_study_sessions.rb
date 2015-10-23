class CreateStudySessions < ActiveRecord::Migration
  def change
    create_table :study_sessions do |t|
      t.string :location
      t.time :start_time
      t.time :end_time
      t.date :day
      t.integer :study_group_id

      t.timestamps null: false
    end
  end
end
