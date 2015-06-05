class PublishersController < InheritedResources::Base

  private

    def publisher_params
      params.require(:publisher).permit()
    end
end

