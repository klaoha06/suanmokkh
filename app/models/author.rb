class Author < ActiveRecord::Base
	has_and_belongs_to_many :books
	validates :name, presence: true, uniqueness: true

	accepts_nested_attributes_for :books

end
