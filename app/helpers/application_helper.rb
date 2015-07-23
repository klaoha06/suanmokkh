module ApplicationHelper
	@sc_user = ''
	def soundcloud_user
		if @sc_user
			return @sc_user
		else
			@sc_user = $sc_consumer.get('/me')
			return @sc_user
		end
	end
	def soundcloud_tracks
			$sc_consumer.get('/me').track_count
	end
	def soundcloud_collections
			$sc_consumer.get('/me').playlist_count
	end
end
