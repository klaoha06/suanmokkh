class RetreatTalksController < InheritedResources::Base

	def index
	    # @retreat_talks = retreat_talk.includes(:authors, :groups, :languages).where(@query).order('created_at DESC').limit(20)
	    # @retreat_talks = RetreatTalk.includes(:authors, :groups, :languages).where(draft: false).order('created_at DESC').page params[:page]
	    @featured_retreat_talks = RetreatTalk.where(featured: true, draft: false).order('created_at DESC').limit(5)
	    # @featured_retreat_talk = retreat_talk.order('created_at DESC').find_by(featured: true)
	    # if !@featured_retreat_talk
	    #   @featured_retreat_talk = @retreat_talks.first
	    # end
	    # @filterrific = initialize_filterrific(
	    #   retreat_talk,
	    #   params[:filterrific]
	    # ) or return
	    # @retreat_talks = @filterrific.find.page(params[:page])

	    # respond_to do |format|
	    #   format.html
	    #   format.js
	    # end
	    # @search = retreat_talk.search(params[:q])
	    # @retreat_talks = @search.result

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
	    # .where(draft: false)

	    # @playlist = $sc_consumer.get("/me/playlists")

	    
	    respond_to do |format|
	      format.html
	      format.js
	    end
	end

	# GET /retreat_talks/1
	# GET /retreat_talks/1.json
	def show
	  @retreat_talk = RetreatTalk.includes(:authors, :audios, :groups, :languages).where(id: params[:id]).first
	  if @retreat_talk == nil
	  	respond_to do |format|
	      format.html { render template: 'shared/_not_found', layout: 'layouts/application', status: 404 }
	      format.all  { render nothing: true, status: 404 }
	  	end
	  else
	  @book = @retreat_talk.books.first
	  @audios = @retreat_talk.audios
	  @audio = @audios.first
	  @audio_languages = 'in ';
	  @related_retreat_talks = RetreatTalk.joins(:audios).where(audios: {audio_code: @retreat_talk.audios.first.audio_code}).where.not(id: params[:id])

	  @related_audios = @retreat_talk.audios

	  @options_for_languages = []
	    @retreat_talk.audios.each do |a|
	  	  language_option = ''
	    	a.languages.each_with_index do |l, index|
	    		# language_options << l.name + ' '
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

