class AudiosController < InheritedResources::Base

	def index
	    # @audios =  Audio.includes(:authors, :groups, :languages, :books).where(@query).order('created_at DESC').limit(20)
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
	    # @search =  Audio.search(params[:q])
	    # @audios = @search.result


	    @audios = $sc_consumer.get('/users/159428232/tracks', :order => 'created_at', limit: 10)

			# @sc_tracks_with_pagination_link = $sc_consumer.get('/users/159428232/tracks', :order => 'created_at', :limit => 20,
   #                  :linked_partitioning => 1)

			# @sc_tracks_with_pagination_link.each_with_index do |object, index|
			# 	if index == 0
			# 		@sc_info = object[0]
			# 		@sc_tracks = object[1]
			# 	end
			# 	if index == 1
			# 		@sc_pagination_link = object[1]
			# 	end
			# end

			# @sc_tracks = $sc_consumer.get('/users/159428232/tracks', :order => 'created_at')

			# @sc_tracks.each do |track|
			#   Audio.creaate({ title: track})
			# end


			# puts $sc_user
			# @number_of_tracks = $sc_user.track_count
			# @number_of_playlist = $sc_user.playlist_count


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

