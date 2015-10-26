require 'rails_helper'

RSpec.describe Student, :type => :model do
  before do
    @student = Student.new(first_name: "Example",
                        last_name: "Student",
                        username: "user@example.edu",
                        password: "foobartest",
                        password_confirmation: "foobartest",
                        institution: "Test")

  end

  it "student should be valid" do
    expect(@student.valid?).to be true
  end

  it "students entire name should be present" do
    @student.first_name = "     "
    expect(@student.valid?).to be false
    @student.first_name = nil
    expect(@student.valid?).to be false

    @student.first_name = "Matt The Wizard"

    @student.last_name = "      "
    expect(@student.valid?).to be false
    @student.last_name = nil
    expect(@student.valid?).to be false
  end

  it "students username should be present" do
    @student.username = "     "
    expect(@student.valid?).to be false
    @student.username = nil
    expect(@student.valid?).to be false
  end

  it "students username should be in the format of a school email ending with .edu" do
    @student.username = "sally@gmail.com"
    expect(@student.valid?).to be false
    @student.username = "sally@yahoo.com"
    expect(@student.valid?).to be false
    @student.username = "sally@uga.org"
    expect(@student.valid?).to be false
    @student.username = "sally@ggc"
    expect(@student.valid?).to be false
    @student.username = "sally@uga.edu"
    expect(@student.valid?).to be true
  end

  it "username must be unique across all students" do
    duplicate_user = @student.dup
    duplicate_user.username = @student.username.upcase
    @student.save
    expect(duplicate_user.valid?).to be false
  end
end
