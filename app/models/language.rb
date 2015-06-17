class Language < ActiveRecord::Base
		validates :name, presence: true, uniqueness: true

	  has_and_belongs_to_many :articles, -> { distinct }
	  has_and_belongs_to_many :news_articles, -> { distinct }
	  has_and_belongs_to_many :audios, -> { distinct }
	  has_and_belongs_to_many :books, -> { distinct }
	  has_and_belongs_to_many :poems, -> { distinct }
	  has_and_belongs_to_many :groups, -> { distinct }

		accepts_nested_attributes_for :articles, allow_destroy: true
		accepts_nested_attributes_for :news_articles, allow_destroy: true
		accepts_nested_attributes_for :audios, allow_destroy: true
		accepts_nested_attributes_for :books, allow_destroy: true
		accepts_nested_attributes_for :poems, allow_destroy: true
		accepts_nested_attributes_for :groups, allow_destroy: true
end
