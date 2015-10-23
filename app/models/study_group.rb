class StudyGroup < ActiveRecord::Base

  has_and_belongs_to_many :students
  has_many :study_sessions

  belongs_to :admin_student, class_name: 'Student'

  validates_presence_of :title
  validates_presence_of :topic

  TITLE_FILTER = "Title"
  TOPIC_FILTER  = "Topic"
  INSTITUTION_FILTER  = "Institution"

  def self.search(params)
    if params[:filter] == TITLE_FILTER
      return StudyGroup.where("title LIKE '%#{params[:search]}%'").to_a
    elsif params[:filter] == TOPIC_FILTER
      return StudyGroup.where("topic LIKE '%#{params[:search]}%'").to_a
    else
      return StudyGroup.where("institution LIKE '%#{params[:search]}%'").to_a
    end
  end

end
