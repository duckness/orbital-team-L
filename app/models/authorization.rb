class Authorization < ActiveRecord::Base
  	belongs_to :user
  	validates_presence_of :uid, :provider
  	validates_uniqueness_of :uid, :scope => :provider

  	def self.find_from_hash(hash)
		find_by(provider: hash['provider'], uid: hash['uid'])
	end
	def self.create_from_hash(hash)
	  	create(:uid => hash['uid'], :provider => hash['provider'])
	end
	def self.create_new_user_from_hash(hash, current_user = nil)
		current_user ||= User.create_from_hash!(hash)
		auth = Authorization.create(:uid => hash['uid'], :provider => hash['provider'])
		current_user
	end
end