class Poem < ActiveRecord::Base
		# Validations
		validates :title, presence: true, uniqueness: true
		validates :content, presence: true

		# File Attachments
		has_attached_file :cover_img, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
		validates_attachment :cover_img, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }
		
		has_and_belongs_to_many :groups, -> { distinct }
		has_and_belongs_to_many :languages, -> { distinct }
		has_and_belongs_to_many :authors, -> { distinct }
		belongs_to :admin_user, inverse_of: :poems


		accepts_nested_attributes_for :groups, allow_destroy: true
		accepts_nested_attributes_for :languages, allow_destroy: true	
		accepts_nested_attributes_for :authors, allow_destroy: true	
end
