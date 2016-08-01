class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@mail4\.doshisha\.ac\.jp/
  validates :email, presence: true, length: { maximum: 255 },
                                format: { with: VALID_EMAIL_REGEX }, 
                                uniqueness: { case_sensitive: false }
                                #inclusion: {in: mail4.doshisha.ac.jp}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
