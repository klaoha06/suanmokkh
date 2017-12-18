class EbooksController < InheritedResources::Base

  private

    def ebook_params
      params.require(:ebook).permit(:name)
    end
end

