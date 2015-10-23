class AddNotesToStudySessions < ActiveRecord::Migration
  def change
    add_column :study_sessions, :notes, :text
  end
end
