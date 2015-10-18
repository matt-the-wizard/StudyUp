class Student < ActiveRecord::Base

  attr_accessor :remember_token

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :username
  validates_presence_of :password_digest
  validates_presence_of :institution

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[edu]+\z/i
  validates :username, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  before_save { self.username = username.downcase }

  has_secure_password

  def Student.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def Student.new_token
    SecureRandom.urlsafe_base64
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

  def self.search(params)
    # TODO: Implement searchable query
  end

end
