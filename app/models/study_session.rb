class StudySession < ActiveRecord::Base

  belongs_to :study_group
  has_many :students, through: :study_group

  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :location
  validates_presence_of :day
  validates_presence_of :study_group


  def self.search(params)
    # only search by date for now
    return StudySession.where("day = #{params[:search].to_formatted_s(:db)}").to_a
  end
end
