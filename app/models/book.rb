class Book < ActiveRecord::Base
	# File Attachments
	has_attached_file :cover_img, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment :cover_img, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }
	has_attached_file :file
  validates_attachment :file, content_type: { content_type: ["application/pdf", "application/epub"] }

	# Validations
	validates :title, presence: true, uniqueness: true
	validates :external_file_link, url: true, unless: ->(book){book.external_file_link.blank?}
	validates :external_cover_img_link, url: true,  unless: ->(book){book.external_cover_img_link.blank?}
  validate :source_of_file
  validate :source_of_cover_img

  # validates :external_file_link, presence: true, unless: ->(book){book.file_file_name.present?}
   # validates :file_file_name, presence: true, unless: ->(book){book.external_file_link.present?}

  # Associations
  has_and_belongs_to_many :authors, -> { distinct }
  has_and_belongs_to_many :publishers, -> { distinct }
  has_and_belongs_to_many :audios, -> { distinct }
  has_and_belongs_to_many :groups, -> { distinct }
  has_and_belongs_to_many :languages, -> { distinct }

	accepts_nested_attributes_for :authors, allow_destroy: true
	accepts_nested_attributes_for :publishers, allow_destroy: true
	accepts_nested_attributes_for :audios, allow_destroy: true
	accepts_nested_attributes_for :groups, allow_destroy: true
	accepts_nested_attributes_for :languages, allow_destroy: true

	# attr_reader :avatar_remote_url
	# has_attached_file :avatar

	before_create :create_remote_url

	def create_remote_url
		if external_file_link && !file
			self.file = URI.parse(external_file_link)
			@file_remote_url = external_file_link
		end
		if external_cover_img_link && !cover_img
			self.cover_img = URI.parse(external_cover_img_link)
			@cover_img_remote_url = external_cover_img_link
		end
	end




	private

  def source_of_file
    if (external_file_link.blank? && file_file_name.blank?)
      errors.add(:file, "Please upload a file OR give an external link/url to the file")
      errors.add(:external_file_link, "Please upload a file OR give an external link/url to the file")
    end
  end

  def source_of_cover_img
    if (external_cover_img_link.blank? && cover_img_file_name.blank?)
      errors.add(:cover_img, "Please upload a cover_img OR give an external link/url to the cover_img")
      errors.add(:external_cover_img_link, "Please upload a cover_img OR give an external link/url to the cover_img")
    end
  end

end
