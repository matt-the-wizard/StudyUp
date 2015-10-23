class RemoveStudentIdFromStudyGroups < ActiveRecord::Migration
  def change
    remove_column :study_groups, :student_id, :integer
  end
end
