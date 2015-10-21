class StudyGroup < ActiveRecord::Base

  has_many :students

  validates_presence_of :title
  validates_presence_of :topic

  TITLE_FILTER = "Title"
  TOPIC_FILTER  = "Topic"
  INSTITUTION_FILTER  = "Institution"

  def self.search(params)
    if params[:filter] == TITLE_FILTER
      return Student.where("title LIKE '%#{params[:search]}%'").to_a
    elsif params[:filter] == TOPIC_FILTER
      return Student.where("topic LIKE '%#{params[:search]}%'").to_a
    else
      return Student.where("institution LIKE '%#{params[:search]}%'").to_a
    end
  end

end
