class Article < ActiveRecord::Base
		validates :title, presence: true, uniqueness: true

		# File attachments
		has_attached_file :photo
		validates_attachment :photo, :presence => true, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }
		has_attached_file :file
	  validates_attachment :file, content_type: { content_type: ["application/pdf", "application/epub"] }

	  # Associations
	  has_and_belongs_to_many :authors, -> { distinct }
	  has_and_belongs_to_many :publishers, -> { distinct }

	  accepts_nested_attributes_for :authors, allow_destroy: true
	  accepts_nested_attributes_for :publishers, allow_destroy: true

		def create
			params.permit!
			@article = Article.new(article_params)
		end

		private

	  def article_params
	    params.require(:article).permit(:id, :author_ids, :publisher_ids, :publishers_attributes, :featured, :title, :file, :publication_date, :content, :group, :language, :reads, :series, :photo, :allow_comments, authors_attributes: [ :id, :name, :first_name, :last_name, :brief_biography ], publishers_attributes: [ :name, :id ])
	  end
end
