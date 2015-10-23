class CreateJoinTableForStudentsAndGroups < ActiveRecord::Migration
  def change
    create_table :students_study_groups, id: false do |t|
      t.integer :student_id
      t.integer :study_group_id
    end

    add_index :students_study_groups, :student_id
    add_index :students_study_groups, :study_group_id
  end
end
