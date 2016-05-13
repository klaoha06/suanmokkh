class GalleryPhotosController < InheritedResources::Base
	def index
		@photos = GalleryPhoto.all
	end

  private

    def gallery_photo_params
      params.require(:gallery_photo).permit(:external_cover_img_link, :img, :caption)
    end
end

