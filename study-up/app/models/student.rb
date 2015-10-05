class Student < ActiveRecord::Base

  #TODO: Finish modeling session with student, then can model
  # associations and build out other subsystems. Logging in and out is
  # the number one priority

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :username
  validates_presence_of :password_digest
  validates_presence_of :institution

end
