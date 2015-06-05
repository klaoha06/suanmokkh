class VideosController < InheritedResources::Base

  private

    def video_params
      params.require(:video).permit()
    end
end

