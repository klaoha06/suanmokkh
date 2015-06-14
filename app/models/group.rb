class Group < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true

	has_attached_file :cover_img, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment :cover_img, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }

  has_and_belongs_to_many :articles, -> { distinct }
  has_and_belongs_to_many :audios, -> { distinct }
  has_and_belongs_to_many :books, -> { distinct }
  has_and_belongs_to_many :languages, -> { distinct }
  has_and_belongs_to_many :poems, -> { distinct }

	accepts_nested_attributes_for :audios, allow_destroy: true
	accepts_nested_attributes_for :articles, allow_destroy: true
	accepts_nested_attributes_for :books, allow_destroy: true
	accepts_nested_attributes_for :languages, allow_destroy: true
	accepts_nested_attributes_for :poems, allow_destroy: true
end
