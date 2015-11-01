class RetreatTalksController < InheritedResources::Base
	def index
		@robot_img = 'http://www.bia.or.th/en/images/photo/08dec.jpg'
		@title = 'Retreat Talks by Ajahn Buddhadasa - Suan Mokkh'
		@featured_retreat_talks = RetreatTalk.where(featured: true, draft: false).order('created_at DESC').limit(5)
		@filter = initialize_filterrific(
			RetreatTalk,
			params[:filterrific],
			:select_options => {
				with_language_id: Language.options_for_select,
				with_author_id: Author.options_for_select,
				with_series: RetreatTalk.options_for_series,
				},
	      # persistence_id: 'shared_key',
	      # default_filter_params: {draft: false},
	      # available_filters: [],
	      ) or return
		@retreat_talks = @filter.find.page(params[:page])
		respond_to do |format|
			format.html
			format.js
		end
	end

	# GET /retreat_talks/1
	# GET /retreat_talks/1.json
	def show
		@retreat_talk = RetreatTalk.includes(:authors, :audios, :groups, :languages).where(id: params[:id], draft: false).first
		if @retreat_talk.blank?
			respond_to do |format|
				format.html { render template: 'shared/_not_found', layout: 'layouts/application', status: 404 }
				format.all  { render nothing: true, status: 404 }
			end
		else
			@title = @retreat_talk.title + " by " + (@retreat_talk.authors.first.name if @retreat_talk.authors.first) + '- Suan Mokkh'
			@img = @retreat_talk.external_cover_img_link || 'http://www.bia.or.th/en/images/photo/08dec.jpg'
			@fall_back_description = "Suanmokkh.org holds audio collection of more than 300 retreat talks during the life time of Ajahn Buddhadasa starting from the 1980\'s to 1990\'s. These audios are mostly translated live by Santikaro given at Suan Mokkh International Dhamma Hermitage."
			id = params[:id]
			low = id.to_i - 3
			high = id.to_i + 3
			@book = @retreat_talk.books.first
			@audios = @retreat_talk.audios
			@audio = @audios.first
			@audio_languages = 'in '
			@related_retreat_talks = (@retreat_talk.related_retreat_talks + RetreatTalk.joins(:audios).where({:id => low..high} || {audios: {audio_code: @retreat_talk.audios.first.audio_code}}).where.not(id: params[:id])).uniq
			@related_audios = @retreat_talk.audios

			@options_for_languages = []
			@retreat_talk.audios.each do |a|
				language_option = ''
				a.languages.each_with_index do |l, index|
					if index != a.languages.count-1 
						language_option << l.name + ' and '
					elsif index == a.languages.count-1
						language_option << l.name
					end
				end
				@options_for_languages << [language_option, a.id]
			end
		end

	end

	private

	def retreat_talk_params
		params.require(:retreat_talk).permit(:name, :code)
	end
end

