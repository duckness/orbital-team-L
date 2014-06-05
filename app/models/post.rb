class Post < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates :user_id, presence: false  #set to true once we get user ID right
  validates :title, presence: true
end
