class Student < ActiveRecord::Base

  attr_accessor :remember_token

  has_and_belongs_to_many :study_groups

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :institution
  validates_presence_of :password_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[edu]+\z/i

  validates :username,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX,
            message: "must have a valid .edu email address, Ex: sally@ggc.edu" },
            uniqueness: { case_sensitive: false }

  validates :password,
            length: { minimum: 6 },
            on: :create

  before_save { self.username = username.downcase }

  has_secure_password

  FIRST_NAME_FILTER = "First Name"
  LAST_NAME_FILTER  = "Last Name"
  INSTITUTION_FILTER  = "Institution"

  def full_name
    "#{first_name} #{last_name}"
  end

  def remember
    self.remember_token = Student.new_token
    update_attribute(:remember_digest, Student.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def Student.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def Student.new_token
    SecureRandom.urlsafe_base64
  end

  def self.search(params)
    if params[:filter] == FIRST_NAME_FILTER
      return Student.where("first_name LIKE '%#{params[:search]}%'").to_a
    elsif params[:filter] == LAST_NAME_FILTER
      return Student.where("last_name LIKE '%#{params[:search]}%'").to_a
    else
      return Student.where("institution LIKE '%#{params[:search]}%'").to_a
    end
  end

end
