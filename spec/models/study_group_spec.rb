require 'rails_helper'

RSpec.describe StudyGroup, :type => :model do
  before do
    @study_group = StudyGroup.new topic: "Chemistry", title: "Science Kids"
  end

  it "study group should be valid" do
    expect(@study_group.valid?).to be true
  end
end
