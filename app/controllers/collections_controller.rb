class CollectionsController < InheritedResources::Base

  private

    def collection_params
      params.require(:collection).permit(:book_id, :related_book_id)
    end
end

