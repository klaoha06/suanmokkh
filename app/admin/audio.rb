ActiveAdmin.register Audio do
	# menu priority: 3
	permit_params :title, :cover_img, :publisher, :description, :group, :language, :plays, :downloads, :path, :series, :file, :draft

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

scope :all, :default => true
scope :published do |products|
  products.where(:draft => false)
end
scope :not_published do |products|
  products.where(:draft => true)
end

end
