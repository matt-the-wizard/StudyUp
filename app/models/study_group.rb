class StudyGroup < ActiveRecord::Base

  has_and_belongs_to_many :students
  has_many :study_sessions

  belongs_to :admin_student, class_name: 'Student'

  validates_presence_of :title
  validates_presence_of :topic

  before_save :_validate_student_limit
  before_save :_assign_admin_student

  TITLE_FILTER = "Title"
  TOPIC_FILTER  = "Topic"
  INSTITUTION_FILTER  = "Institution"

  def student_in_group?(student)
    self.students.where(id: student.id).first.present?
  end

  def available_space
    self.student_limit.to_i - self.students.count.to_i
  end

  def self.search(params)
    if params[:filter] == TITLE_FILTER
      return StudyGroup.where("title LIKE '%#{params[:search]}%'").to_a
    elsif params[:filter] == TOPIC_FILTER
      return StudyGroup.where("topic LIKE '%#{params[:search]}%'").to_a
    else
      return StudyGroup.where("institution LIKE '%#{params[:search]}%'").to_a
    end
  end

  private

  def _validate_student_limit
    if available_space == 0
      errors.add(:students, "The student limit for this group is full, you cannot join this group.")
      return false
    else
      return true
    end
  end

  def _assign_admin_student
    self.admin_student = self.students.first if self.admin_student.nil? && self.students.count.to_i > 0
  end

end
