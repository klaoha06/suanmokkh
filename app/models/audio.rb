class Audio < ActiveRecord::Base
	validates :title, presence: true
	# validates :soundcloud_identifier, uniqueness: true
	validates :uri, presence: true

	has_attached_file :file
	validates_attachment :file, content_type: { content_type: [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]}

	has_and_belongs_to_many :books, -> { distinct }
	has_and_belongs_to_many :retreat_talks, -> { distinct }
	has_and_belongs_to_many :authors, -> { distinct }
	has_and_belongs_to_many :languages, -> { distinct }
	has_and_belongs_to_many :groups, -> { distinct }
	belongs_to :admin_user, inverse_of: :audios


	accepts_nested_attributes_for :books, allow_destroy: true
	accepts_nested_attributes_for :retreat_talks, allow_destroy: true
	accepts_nested_attributes_for :authors, allow_destroy: true
	accepts_nested_attributes_for :languages, allow_destroy: true
	accepts_nested_attributes_for :groups, allow_destroy: true

		def embeded_audio(width = '100%', height = '150')
				return "<iframe width='" + width + "' height='" + height +"' scrolling='no' frameborder='no' src='https://w.soundcloud.com/player/?url=" + (self.secret_uri ||= self.uri) + "&amp;color=725843&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false&amp;show_user=false'></iframe>"
		end

		def embeded_audio_link_banner(width = '90%', height = '400')
			return '<iframe class="floatCenter" width="' + width +'" height="' + height +'" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=' + (self.secret_uri ||= self.uri) + '&amp;color=725843&amp;auto_play=false&amp;hide_related=true&amp;show_comments=false&amp;show_user=true&amp;show_reposts=false&amp;visual=true"></iframe>'
		end

		def embeded_audio_link_strip(width = '100%', height = '20')
			return '<iframe width="' + width +'" height="' + height +'" frameborder="no" src="https://w.soundcloud.com/player/?url=' + (self.secret_uri ||= self.uri) + '&amp;color=ff5500&amp;inverse=false&amp;auto_play=false&amp;show_user=true"></iframe>'
		end

		def self.options_for_retreat_talk_languages (retreat_talk_id)
			# joins(:languages, :retreat_talk).where(retreat_talks: {retreat_talk_id: retreat_talk_id})
		end

		filterrific(
		  available_filters: [
		    :with_language_id,
		  ]
		)

		def self.with_language_id language_id
		  joins(:languages).where(languages: {id: language_id})
		end

		def self.options_for_languages retreat_talk_id
		  # p joins(:audios, :languages).order('LOWER(name)').map { |e| [e.name, e.id] }
		  options = []
		  joins(:retreat_talks).find(retreat_talk_id).audios.each do |a|
			  language_option = ''
		  	a.languages.each_with_index do |l, index|
		  		# language_options << l.name + ' '
		  		if index != a.languages.count-1 
		  			language_option << l.name + ' and '
		  		elsif index == a.languages.count-1
		  			language_option << l.name
		  		end
		  	end
		  	options << language_option
		  end
		  options
		end


		# def create
		# 	@audio = Audio.new(audio_params)
		# end

		private

	  def audio_params
	    params.require(:audio).permit(:title, :uri, :secret_uri, :publisher, :description, :group, :language, :downloads, :embeded_audio_link, :external_link, :series, :file, :featured, :draft, :creattion_date, :allow_comments)
	  end
end
