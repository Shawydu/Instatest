class Gram < ActiveRecord::Base
	mount_uploader :picture, PictureUploader
	belongs_to :user
	has_many :comments, dependent: :destroy

	validates :message, :presence => true
	validates :picture, :presence => true
end
