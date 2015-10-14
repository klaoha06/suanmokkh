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
	      # default_filter_params: {},
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
	  @retreat_talk = RetreatTalk.includes(:authors, :audios, :groups, :languages).where(id: params[:id]).first
	  # @audios_languages = 'in ';
	  # @retreat_talk.audios.each do |audio|
	  #   @audios_languages + audio.languages.name + " " if audio.language.name
	  # end
	  @book = @retreat_talk.books.first
	end

  private

    def retreat_talk_params
      params.require(:retreat_talk).permit(:name, :code)
    end
end

