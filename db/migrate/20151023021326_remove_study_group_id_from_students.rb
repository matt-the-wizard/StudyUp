class RemoveStudyGroupIdFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :study_group_id
  end
end
