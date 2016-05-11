class GalleryPhotosController < InheritedResources::Base

  private

    def gallery_photo_params
      params.require(:gallery_photo).permit()
    end
end

