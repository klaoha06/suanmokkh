class CatagoriesController < InheritedResources::Base

  private

    def catagory_params
      params.require(:catagory).permit()
    end
end

