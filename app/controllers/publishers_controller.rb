class PublishersController < InheritedResources::Base
	
  private

    def author_params
      params.require(:author).permit()
    end
end

