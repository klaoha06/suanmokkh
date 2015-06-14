class Author < ActiveRecord::Base
	has_and_belongs_to_many :books, -> { distinct }
	has_and_belongs_to_many :articles, -> { distinct }
	has_and_belongs_to_many :audios, -> { distinct }
	validates :name, presence: true, uniqueness: true

	accepts_nested_attributes_for :books
	accepts_nested_attributes_for :articles
	accepts_nested_attributes_for :audios

end
