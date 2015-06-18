class Author < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true

	has_and_belongs_to_many :books, -> { distinct }
	has_and_belongs_to_many :articles, -> { distinct }
	has_and_belongs_to_many :audios, -> { distinct }
	has_and_belongs_to_many :poems, -> { distinct }

	accepts_nested_attributes_for :books, allow_destroy: true
	accepts_nested_attributes_for :articles, allow_destroy: true
	accepts_nested_attributes_for :audios, allow_destroy: true
	accepts_nested_attributes_for :poems, allow_destroy: true

end
