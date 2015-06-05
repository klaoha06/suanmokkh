class AudiosController < InheritedResources::Base

  private

    def audio_params
      params.require(:audio).permit()
    end
end

