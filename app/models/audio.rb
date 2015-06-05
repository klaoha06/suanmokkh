class Audio < ActiveRecord::Base
	has_attached_file :file, styles: {thumbnail: "60x60#"}

		def create
			@audio = Audio.new(audio_params)
		end

		private

	  def audio_params
	    params.require(:audio).permit(:title, :cover_img, :publisher, :description, :group, :language, :downloads, :path, :series, :file)
	  end
end
