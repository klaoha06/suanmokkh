class Publisher < ActiveRecord::Base
	has_and_belongs_to_many :books, -> { distinct }, :uniq => true
	has_and_belongs_to_many :articles, -> { distinct }, :uniq => true
	validates :name, presence: true, uniqueness: true

	accepts_nested_attributes_for :books
	accepts_nested_attributes_for :articles

end
