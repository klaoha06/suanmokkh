class Book < ActiveRecord::Base
	# params.permit!
	# params.require(:book).permit!

	# Validations
	validates :title, presence: true, uniqueness: true

	# File Attachments
	has_attached_file :cover_img, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment :cover_img, :presence => true, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }
	has_attached_file :file
  validates_attachment :file, :presence => true, content_type: { content_type: ["application/pdf", "application/epub"] }

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

	def create
		params.permit!
		@book = Book.new(book_params)
	end

	private

  def book_params
    params.require(:book).permit(:language_ids, :group_ids, :author_ids,:audio_ids, :publisher_ids, :language_ids, :languages_attributes, :group_ids, :groups_attributes, :author_ids, :audio_ids, :publisher_ids, :id, :title, :cover_img, :publisher, :description, :group, :language, :isbn_10, :isbn_13, :downloads, :draft, :series, :file, :allow_comments, :weight, :pages, :publication_date, :format, :price, :featured, :author_ids, authors_attributes: [ :id, :name, :first_name, :last_name, :brief_biography ], publishers_attributes: [ :name ])
  end

end
