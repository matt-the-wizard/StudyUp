class StudySession < ActiveRecord::Base

  belongs_to :study_group
  has_many :students, through: :study_group

  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :location
  validates_presence_of :day

  def self.search(params)
    # only search by date for now
    return StudySession.where("day = #{params[:search]}").to_a
  end
end
