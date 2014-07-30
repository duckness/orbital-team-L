class User < ActiveRecord::Base

	has_many :authorizations
	before_save { self.email = email.downcase }
	before_create  :create_remember_token 

  has_many :posts
	validates :name,  presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
			uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 8 }
	validates :password_confirmation, presence: true

	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def User.digest(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end

  	def self.create_from_hash!(hash)
  		randomPassword = SecureRandom.urlsafe_base64(6)
	  	create(:name => hash['info']['name'], :email => hash['info']['email'], 
	  		:password => randomPassword, :password_confirmation => randomPassword)
	end

	
	private

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
