require 'rails_helper'

RSpec.describe StudyGroup, :type => :model do
  before do
    @study_group = StudyGroup.new topic: "Chemistry", title: "Science Kids"

    @student = Student.new(first_name: "Example",
                        last_name: "Student",
                        username: "user@example.edu",
                        password: "foobar",
                        password_confirmation: "foobar",
                        institution: "Test")

    @student_two = Student.new(first_name: "Example2",
                        last_name: "Student2",
                        username: "user2@example.edu",
                        password: "foobar2",
                        password_confirmation: "foobar2",
                        institution: "Test2")

    @study_group.admin_student = @student
    @study_group.students << @student
    @study_group.save!
  end

  it "study group should be valid" do
    expect(@study_group.valid?).to be true
  end

  it "study group topic and title should be present" do
    @study_group.topic = "     "
    expect(@study_group.valid?).to be false
    @study_group.topic = nil
    expect(@study_group.valid?).to be false

    @study_group.topic = "Biology"

    @study_group.title = "      "
    expect(@study_group.valid?).to be false
    @study_group.title = nil
    expect(@study_group.valid?).to be false
  end

  it "adds a student, removes a student without deleting the student record, assigns new admin if admin leaves the group" do
    @study_group.add_student @student_two
    expect(@study_group.students.count).to be 2

    @study_group.remove_student @student
    expect(@study_group.students.count).to be 1
    expect(@study_group.admin_student_id).to be @student_two.id
    expect(Student.find(@student.id)).to_not be nil
  end

  it "should delete the group if no students are left" do
    @study_group.remove_student @student
    expect(StudyGroup.where id: @study_group.id).to_not exist
  end

end
