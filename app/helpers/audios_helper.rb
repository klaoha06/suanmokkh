module AudiosHelper
	def soundcloud_user
			$sc_consumer.get('/me')
	end
	def soundcloud_tracks
			$sc_consumer.get('/me').track_count
	end
	def soundcloud_collections
			$sc_consumer.get('/me').playlist_count
	end
end
