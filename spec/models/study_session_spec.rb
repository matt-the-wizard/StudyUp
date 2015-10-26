require 'rails_helper'

RSpec.describe StudySession, :type => :model do
  before do
    @study_session = StudySession.new location: "Library",
                                       day: "2015-12-01",
                                       start_time: "02:00 PM",
                                       end_time: "03:00 PM"

    @study_group = StudyGroup.new topic: "Chemistry",
                                  title: "Science Kids"

    @study_session.study_group = @study_group
    @study_session.save!

  end

  it "study Session should be valid" do
    expect(@study_session.valid?).to be true
  end

  it "study session location, start_time,end_time,day should be present" do
    @study_session.location = "     "
    expect(@study_session.valid?).to be false
    @study_session.location = nil
    expect(@study_session.valid?).to be false

    @study_session.location = "Georgia Gwinnett College"

    @study_session.start_time = "      "
    expect(@study_session.valid?).to be false
    @study_session.start_time = nil
    expect(@study_session.valid?).to be false

    @study_session.start_time = "02:00 PM"

    @study_session.end_time = "      "
    expect(@study_session.valid?).to be false
    @study_session.end_time = nil
    expect(@study_session.valid?).to be false

    @study_session.end_time = "03:00 PM"

    @study_session.day = "      "
    expect(@study_session.valid?).to be false
    @study_session.day = nil
    expect(@study_session.valid?).to be false
  end
end
