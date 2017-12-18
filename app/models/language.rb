class Language < ActiveRecord::Base
		validates :name, presence: true, uniqueness: true

	  has_and_belongs_to_many :articles, -> { distinct }, :uniq => true
	  has_and_belongs_to_many :news_articles, -> { distinct }, :uniq => true
	  has_and_belongs_to_many :audios, -> { distinct }, :uniq => true
	  has_and_belongs_to_many :books, -> { distinct }, :uniq => true
	  has_and_belongs_to_many :ebooks, -> { distinct }, :uniq => true
	  has_and_belongs_to_many :retreat_talks, -> { distinct }, :uniq => true
	  has_and_belongs_to_many :poems, -> { distinct }, :uniq => true
	  has_and_belongs_to_many :groups, -> { distinct }, :uniq => true

		accepts_nested_attributes_for :articles, allow_destroy: true
		accepts_nested_attributes_for :news_articles, allow_destroy: true
		accepts_nested_attributes_for :audios, allow_destroy: true
		accepts_nested_attributes_for :retreat_talks, allow_destroy: true
		accepts_nested_attributes_for :books, allow_destroy: true
		accepts_nested_attributes_for :ebooks, allow_destroy: true
		accepts_nested_attributes_for :poems, allow_destroy: true
		accepts_nested_attributes_for :groups, allow_destroy: true

		def self.options_for_select
		  order('LOWER(name)').map { |e| [e.name, e.id] }
		end
end
