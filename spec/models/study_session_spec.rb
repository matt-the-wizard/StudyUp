require 'rails_helper'

RSpec.describe StudySession, :type => :model do
  before do
    @study_sessions = StudySession.new location: "Library", day: "2015-12-01",start_time: "02:00 PM",
  end_time: "03:00 PM"
  end

  it "study Session should be valid" do
    expect(@study_sessions.valid?).to be true
  end

  it "study session location, start_time,end_time,day should be present" do
    @study_sessions.location = "     "
    expect(@study_sessions.valid?).to be false
    @study_sessions.location = nil
    expect(@study_sessions.valid?).to be false

    @study_sessions.location = "Georgia Gwinnett College"

    @study_sessions.start_time = "      "
    expect(@study_sessions.valid?).to be false
    @study_sessions.start_time = nil
    expect(@study_sessions.valid?).to be false

    @study_sessions.start_time = "02:00 PM"

    @study_sessions.end_time = "      "
    expect(@study_sessions.valid?).to be false
    @study_sessions.end_time = nil
    expect(@study_sessions.valid?).to be false

    @study_sessions.end_time = "03:00 PM"

    @study_sessions.day = "      "
    expect(@study_sessions.valid?).to be false
    @study_sessions.day = nil
    expect(@study_sessions.valid?).to be false

    @study_sessions.day = "2015-01-12"

  end
end
