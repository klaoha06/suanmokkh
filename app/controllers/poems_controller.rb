class PoemsController < InheritedResources::Base
	def index
	    @featured_poems = Poem.where(featured: true, draft: false).order('created_at DESC').limit(5)
	
	    @filter = initialize_filterrific(
	      Poem,
	      params[:filterrific],
	      # :select_options => {
	      #   with_language_id: Language.options_for_select,
	      #   with_author_id: Author.options_for_select,
	      #   with_series: Poem.options_for_series,
	      # },
	      # persistence_id: 'shared_key',
	      # default_filter_params: {draft: false},
	      # available_filters: [],
	    ) or return
	    @poems = @filter.find.page(params[:page]).where(draft: false).order("RANDOM()")
	    # .where(draft: false)
	    
	    respond_to do |format|
	      format.html
	      format.js
	    end
	end

	# GET /poems/1
	# GET /poems/1.json
	def show
	  @poem = Poem.includes(:authors).where(id: params[:id]).first
	end

  private

    def poem_params
      params.require(:poem).permit()
    end
end

