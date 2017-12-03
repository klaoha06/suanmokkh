class Article < ActiveRecord::Base
		# File attachments
		has_attached_file :cover_img, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
		validates_attachment :cover_img, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
		has_attached_file :file
	  validates_attachment :file, content_type: { content_type: ["application/pdf", "application/epub"] }

	  # Associations
	  has_and_belongs_to_many :authors, -> { distinct }
	  has_and_belongs_to_many :publishers, -> { distinct }
	  has_and_belongs_to_many :groups, -> { distinct }
	  has_and_belongs_to_many :languages, -> { distinct }
	  belongs_to :admin_user, inverse_of: :articles


	  accepts_nested_attributes_for :authors, allow_destroy: true
	  accepts_nested_attributes_for :publishers, allow_destroy: true
	  accepts_nested_attributes_for :groups, allow_destroy: true
	  accepts_nested_attributes_for :languages, allow_destroy: true

		validates :title, presence: true, uniqueness: true
		# validates :external_file_link, url: true, unless: ->(article){article.external_file_link.blank?}
		# validates :external_cover_img_link, url: true, unless: ->(article){article.external_cover_img_link.blank?}
		# validate :source_of_file
		# validate :source_of_cover_img

		paginates_per 16

		filterrific(
		  available_filters: [
		    :search_query,
		    :with_language_id,
		    :with_author_id,
		    :with_series,
		  ]
		)

		scope :search_query, lambda { |query|
		  return nil  if query.blank?
		  # condition query, parse into individual keywords
		  terms = query.to_s.downcase.split(/\s+/)
		  # replace "*" with "%" for wildcard searches,
		  # append '%', remove duplicate '%'s
		  terms = terms.map { |e|
		    ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
		  }
		  # configure number of OR conditions for provision
		  # of interpolation arguments. Adjust this if you
		  # change the number of OR conditions.
		  num_or_conditions = 1
		  where(
		    terms.map {
		      or_clauses = [
		        "LOWER(articles.title) LIKE ?",
		        # "LOWER(articles.description) LIKE ?",
		        # "LOWER(students.email) LIKE ?"
		      ].join(' OR ')
		      "(#{ or_clauses })"
		    }.join(' AND '),
		    *terms.map { |e| [e] * num_or_conditions }.flatten
		  )
		}

		def self.with_language_id language_id
		  joins(:languages).where(languages: { id: language_id })
		end

		def self.with_author_id author_id
		  joins(:authors).where(authors: { id: author_id })
		end

		def self.with_series series
		  where(series: series).uniq
		end

		def self.options_for_series
		  where.not('series' => '').pluck(:series).uniq
		end

		# Before create
		before_create :before_creation

		def before_creation
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
