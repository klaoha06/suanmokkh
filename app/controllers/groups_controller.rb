class GroupsController < InheritedResources::Base

  private

    def group_params
      params.require(:group).permit(:name, :date, :external_cover_img_link)
    end
end

