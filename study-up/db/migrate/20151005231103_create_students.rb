class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password_digest
      t.string :institution
      t.string :discipline
      t.string :school_of_study
      t.integer :phone_number

      t.timestamps null: false
    end
  end
end
