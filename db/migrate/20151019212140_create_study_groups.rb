class CreateStudyGroups < ActiveRecord::Migration
  def change
    create_table :study_groups do |t|
      t.integer :student_id
      t.string :title
      t.string :topic
      t.string :institution
      t.integer :student_limit
      t.integer :admin_student_id

      t.timestamps null: false
    end
  end
end
