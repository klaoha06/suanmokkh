class Poem < ActiveRecord::Base
		# Validations
		validates :title, presence: true, uniqueness: true
		validates :content, presence: true
		# validate :source_of_cover_img

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

		attr_reader :cover_img_remote_url

		before_create :create_remote_url

		paginates_per 12

		def create_remote_url
		  if external_cover_img_link && !cover_img
		    self.cover_img = URI.parse(external_cover_img_link)
		    # self.cover_img.url = external_cover_img_link
		    # @cover_img_remote_url = external_cover_img_link
		  end
		end

		filterrific(
		  available_filters: [
		    :search_query,
		    # :with_language_id,
		    # :with_author_id,
		    # :with_series,
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
		        "LOWER(poems.title) LIKE ?",
		        # "LOWER(books.description) LIKE ?",
		        # "LOWER(students.email) LIKE ?"
		      ].join(' OR ')
		      "(#{ or_clauses })"
		    }.join(' AND '),
		    *terms.map { |e| [e] * num_or_conditions }.flatten
		  )
		}

end
