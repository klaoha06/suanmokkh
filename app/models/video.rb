class Video < ActiveRecord::Base
	has_attached_file :file, styles: {thumbnail: "60x60#"}

		def create
			@video = Video.new(video_params)
		end

		private

	  def video_params
	    params.require(:video).permit(:title, :cover_img, :publisher, :description, :group, :language, :downloads, :path, :series, :file)
	  end
end
