class GalleryPhoto < ActiveRecord::Base
	has_attached_file :img, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment :img, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }
end
