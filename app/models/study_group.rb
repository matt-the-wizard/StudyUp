class StudyGroup < ActiveRecord::Base

  has_many :students

  validates_presence_of :title
  validates_presence_of :topic

end
