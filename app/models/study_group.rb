class StudyGroup < ActiveRecord::Base

  has_and_belongs_to_many :students
  has_many :study_sessions

  belongs_to :admin_student, class_name: 'Student'

  validates_presence_of :title
  validates_presence_of :topic
  validates :student_limit, allow_blank: true, numericality: { only_integer: true }

  before_save :_validate_student_limit
  before_save :_assign_admin_student
  after_save  :_destroy_group

  TITLE_FILTER = "Title"
  TOPIC_FILTER  = "Topic"
  INSTITUTION_FILTER  = "Institution"

  def student_in_group?(student)
    self.students.where(id: student.id).first.present?
  end

  def available_space
    self.student_limit.to_i - self.students.count.to_i
  end

  # Join a group
  def add_student a_student
    self.students << a_student unless self.students.include? a_student.id
    self.save!
  end

  # Leave a group
  def remove_student a_student
    # Just need to delete the relationship but not the actual record
    new_student_list = []
    self.students.each do |student|
      new_student_list << student unless student.id == a_student.id
    end
    self.students = new_student_list
    self.admin_student = nil if self.admin_student.id == a_student.id # Handle admin leaving group to force assign admin callback
    self.save!
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
    return true if self.student_limit.nil?
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

  def _destroy_group
    self.destroy! if self.admin_student.nil? && self.students.empty?
  end

end
