class Audio < ActiveRecord::Base
	validates :title, presence: true, uniqueness: true

	has_attached_file :file
	validates_attachment :file, content_type: { content_type: [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]}

	has_and_belongs_to_many :books, -> { distinct }
	has_and_belongs_to_many :authors, -> { distinct }
	has_and_belongs_to_many :languages, -> { distinct }
	has_and_belongs_to_many :groups, -> { distinct }

	accepts_nested_attributes_for :books
	accepts_nested_attributes_for :authors
	accepts_nested_attributes_for :languages
	accepts_nested_attributes_for :groups

		def create
			@audio = Audio.new(audio_params)
		end

		private

	  def audio_params
	    params.require(:audio).permit(:title, :publisher, :description, :group, :language, :downloads, :embeded_audio_link, :external_link, :series, :file, :featured, :draft, :creattion_date, :allow_comments)
	  end
end
