class RetreatTalksController < InheritedResources::Base

  private

    def retreat_talk_params
      params.require(:retreat_talk).permit(:name, :code)
    end
end

