class PoemsController < InheritedResources::Base

  private

    def poem_params
      params.require(:poem).permit()
    end
end

