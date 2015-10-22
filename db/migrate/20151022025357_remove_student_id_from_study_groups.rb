class RemoveStudentIdFromStudyGroups < ActiveRecord::Migration
  def change
    # TODO: Determine if this is needed
    remove_column :study_groups, :student_id, :integer
  end
end
