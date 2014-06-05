class User < ActiveRecord::Base
  has_many :posts
  before_save { self.email = email.downcase }

  #Max lengths are to prevent name from being stupidly long and overflowing on pages, and the rest to prevent attacks on the server with megabyte length strings

  validates :name, presence: true, length: {  maximum: 50  }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, length: {  maximum: 512  }, uniqueness: {  case_sensitive: false  }

  validates :password, length: {  minimum: 8, maximum: 512  }
  has_secure_password
end
