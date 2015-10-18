class RelationshipsController < InheritedResources::Base

  private

    def relationship_params
      params.require(:relationship).permit(:retreat_talk_id, :related_retreat_talk_id, :create, :destroy)
    end
end

