class Post < ActiveRecord::Base
  mount_uploader :vector, ImageUploader
  belongs_to :user

  default_scope -> { order('created_at DESC') }

  validates :user_id, presence: false  #set to true once we get user ID right
  validates :title, presence: true
end
