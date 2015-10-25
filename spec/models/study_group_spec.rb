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

  it "should add a student if they join a group, remove a student if they leave a group but not delete the student record" do
    @study_group.add_student @student
    expect(@study_group.students.count).to be 1

    @study_group.remove_student @student
    expect(@study_group.students.count).to be 0
    expect(Student.find(@student.id)).to_not be nil
  end

end
