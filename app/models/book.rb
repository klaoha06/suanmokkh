class Book < ActiveRecord::Base
  # Scopes
  scope :ebook, ->{where(ebook: true)}
  scope :normalbook, ->{where(normalbook: true)}
  scope :with_type, lambda { |type|
    if type == "eBook"
      where(ebook: true)
    elsif type == "Book"
      where(normalbook: true)
    else
      Book.includes(:authors, :audios, :groups, :languages, :related_books).where(id: params[:id], draft: false).first
    end
  }

  # File Attachments
  has_attached_file :cover_img, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment :cover_img, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }
  has_attached_file :file
  validates_attachment :file, content_type: { content_type: ["application/pdf"] }
  has_attached_file :epub, { validate_media_type: false }
  # validates_attachment_file_name :epub, matches: [/epub\z/, /epub?g\z/]
  has_attached_file :mobi
  validates_attachment_file_name :mobi, matches: [/mobi\z/, /mobi?g\z/]

  before_post_process :set_content_type

  def set_content_type
    # debugger  
    # self.epub.instance_write(:content_type, MIME::Types.type_for(self.epub_file_name).first.to_s)
    # debugger
  end

  # Validations
  validates :title, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  # validates :external_file_link, url: true, unless: ->(book){book.external_file_link.blank?}
  validates :external_cover_img_link, url: true,  unless: ->(book){book.external_cover_img_link.blank?}
  # validate :source_of_file
  validate :source_of_cover_img
  validate :presence_of_ebook_or_book

  def presence_of_ebook_or_book
    if normalbook == false && ebook == false
      errors.add(:normalbook, "ebook or normalbook must be true")
      errors.add(:ebook, "ebook or normalbook must be true")
    end
  end

  # validates :external_file_link, presence: true, unless: ->(book){book.file_file_name.present?}
  # validates :file_file_name, presence: true, unless: ->(book){book.external_file_link.present?}

  # Associations
  has_and_belongs_to_many :authors, -> { distinct }, :uniq => true
  has_and_belongs_to_many :retreat_talks, -> { distinct }
  has_and_belongs_to_many :publishers, -> { distinct }, :uniq => true
  has_and_belongs_to_many :audios, -> { distinct }
  has_and_belongs_to_many :groups, -> { distinct }, :uniq => true
  has_and_belongs_to_many :languages, -> { distinct }, :uniq => true
  belongs_to :admin_user, inverse_of: :books

  has_many :collections
  has_many :related_books, :through => :collections
  has_many :inverse_collections, :class_name => "Collection", :foreign_key => "related_book_id"
  has_many :inverse_related_books, :through => :inverse_collections, :source => :book

	accepts_nested_attributes_for :authors, allow_destroy: true
	accepts_nested_attributes_for :retreat_talks, allow_destroy: true
	accepts_nested_attributes_for :publishers, allow_destroy: true
	accepts_nested_attributes_for :audios, allow_destroy: true
	accepts_nested_attributes_for :groups, allow_destroy: true
	accepts_nested_attributes_for :languages, allow_destroy: true

  attr_reader :cover_img_remote_url
  # has_attached_file :avatar

  before_create :create_remote_url

  paginates_per 16

  def create_remote_url
    if external_file_link && !file
      self.file = URI.parse(external_file_link)
      # self.file.url = external_file_link
      # @file_remote_url = external_file_link
    end
    if external_cover_img_link && !cover_img
      self.cover_img = URI.parse(external_cover_img_link)
      # self.cover_img.url = external_cover_img_link
      # @cover_img_remote_url = external_cover_img_link
    end
  end

  # def self.search language, author, series
  #   query_obj = includes(:authors, :groups, :languages)
  #   query_obj = query_obj.where({languages: { name: language}}) unless language.blank?
  #   query_obj = query_obj.where({authors: { first_name: author}}) unless author.blank?
  #   query_obj = query_obj.where(series: series) unless series.blank?

  #   query_obj
  # end


  filterrific(
    available_filters: [
      :search_query,
      :with_language_id,
      :with_type,
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
          "LOWER(books.title) LIKE ?",
          # "LOWER(books.description) LIKE ?",
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

  # def self.with_type type
  #   if type == "ebook"
  #     where(ebook: true)
  #   elsif type == "normalbook"
  #     where(normalbook: true)
  #   end
  # end

  def self.with_series series
    where(series: series).uniq
  end

  def self.options_for_series
    where.not('series' => '').pluck(:series).uniq
  end

  def self.options_for_type
    where(normalbook: true, ebook: true)
  end

  def show_book
      if !self.external_file_link.blank? 
        return '<iframe src="' + self.external_file_link + '#page=1&zoom=100' + '"#view=fit" width="100%" height="1000px" border="0" style="border:none" scrolling="no"></iframe>'
      elsif !self.file.url.blank? && !self.file.url.include?('missing')
        return '<iframe src="' + self.file.url + '#page=1&zoom=100' + '"#view=fitH" width="100%" height="1000px" border="0" style="border:none" scrolling="no"></iframe>'
      else
        return false
      end 
  end

  def show_book_mobile
      if !self.external_file_link.blank? 
        'https://docs.google.com/viewer?url=' + self.external_file_link + '&embedded=true'
      elsif !self.file.url.blank? && !self.file.url.include?('missing')
        'https://docs.google.com/viewer?url=suanmokkh.org/' + self.file.url + '&embedded=true'
      else
        return false
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
