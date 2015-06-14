class NewsArticle < ActiveRecord::Base
	# Validations
	validates :title, presence: true, uniqueness: true
	validates :content, presence: true

	# File Attachments
	has_attached_file :cover_img, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment :cover_img, :presence => true, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }
	
end
