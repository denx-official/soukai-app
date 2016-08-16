class Soukai < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  belongs_to :attendance
end
