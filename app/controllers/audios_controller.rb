class AudiosController < InheritedResources::Base

	def index
	    @audios =  Audio.includes(:authors, :groups, :languages, :books).where(@query).order('created_at DESC').limit(20)
	    # @featured_audios =  Audio.includes(:authors, :groups, :languages).where(featured: true).order('created_at DESC').limit(10)
	    # @featured_audio = audio.order('created_at DESC').find_by(featured: true)
	    # if !@featured_audio
	    #   @featured_audio = @audios.first
	    # end
	    # @filterrific = initialize_filterrific(
	    #   audio,
	    #   params[:filterrific]
	    # ) or return
	    # @audios = @filterrific.find.page(params[:page])

	    # respond_to do |format|
	    #   format.html
	    #   format.js
	    # end
	    @search =  Audio.search(params[:q])
	    @audios = @search.result
	end

	# GET /audios/1
	# GET /audios/1.json
	def show
	  @audio = Audio.includes(:authors, :groups, :languages, :books).where(id: params[:id]).first
	  # @audios_languages = 'in ';
	  # @audio.audios.each do |audio|
	  #   @audios_languages + audio.languages.name + " " if audio.language.name
	  # end
	end

  private

    def audio_params
      params.require(:audio).permit()
    end
end

