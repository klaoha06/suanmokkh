ActiveAdmin.register Article do
		menu priority: 2
		permit_params :title, :photo, :publisher, :content, :group, :language, :reads, :series, :draft, :allow_comments

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
	index do
		selectable_column
		id_column
		column :title
		# column :content
		column :language
		column :publisher
		column :series
		column :group
		column :draft
		column :featured
		column :cover_img
		column :created_at
	  actions
	end

	index as: :blog do
	  title :title # Calls #my_title on each resource
	  body  :content  # Calls #my_body on each resource
	end

	scope :all, :default => true
	scope :published do |products|
	  products.where(:draft => false)
	end
	scope :not_published do |products|
	  products.where(:draft => true)
	end
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
form :html => { :enctype => "multipart/form-data" } do |f|
	tabs do
	      tab 'Basic' do
	        f.inputs 'Basic Details' do
	        	f.input :title, :required => true
	        	f.input :content, :as => :ckeditor, :input_html => { :ckeditor => { :height => 400 } }
	        	f.input :language
	        	f.input :series
	        end
	        f.inputs 'Actual Files' do
	        	# f.input :file, hint: f.book.file? ? link_to(f.book.file_file_name, f.book.file.url) : content_tag(:span, "Upload PDF file")
	        	# f.input :photo, hint: f.article.photo? ? image_tag(f.article.photo.url, height: '200') : content_tag(:span, "Upload JPG/PNG/GIF image")
	        	f.input :photo
	        end
	        f.inputs 'Publish Status' do
	        	f.input :draft, :label => "publish or not to publish.."
	        	f.input :featured
	        	f.input :allow_comments, :label => "Allow commenting on this article"
	        end
	      end
	    end
	f.actions
end


end
