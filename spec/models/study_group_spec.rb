require 'rails_helper'

RSpec.describe StudyGroup, :type => :model do
  before do
    @study_group = StudyGroup.new topic: "Chemistry", title: "Science Kids"
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

    @study_group.title = "Cool Crew"

  end


end
