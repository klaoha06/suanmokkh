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
  has_and_belongs_to_many :retreat_talks, -> { distinct }
  has_and_belongs_to_many :publishers, -> { distinct }
  has_and_belongs_to_many :audios, -> { distinct }
  has_and_belongs_to_many :groups, -> { distinct }
  has_and_belongs_to_many :languages, -> { distinct }
  belongs_to :admin_user, inverse_of: :books

	accepts_nested_attributes_for :authors, allow_destroy: true
	accepts_nested_attributes_for :retreat_talks, allow_destroy: true
	accepts_nested_attributes_for :publishers, allow_destroy: true
	accepts_nested_attributes_for :audios, allow_destroy: true
	accepts_nested_attributes_for :groups, allow_destroy: true
	accepts_nested_attributes_for :languages, allow_destroy: true

  attr_reader :cover_img_remote_url
  # has_attached_file :avatar

  before_create :create_remote_url

  paginates_per 12

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

  def self.search language, author, series
    query_obj = includes(:authors, :groups, :languages)
    query_obj = query_obj.where({languages: { name: language}}) unless language.blank?
    query_obj = query_obj.where({authors: { first_name: author}}) unless author.blank?
    query_obj = query_obj.where(series: series) unless series.blank?

    query_obj
  end


  filterrific(
    available_filters: [
      :with_language_id,
    ]
  )

  def self.with_language_id language_id
    Language.find(language_id).books
  end
  # scope :with_language_id, lambda { |language_ids|
    
  # }

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
