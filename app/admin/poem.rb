ActiveAdmin.register Poem do
	permit_params :id, :title, :cover_img, :content, :group, :language, :draft, :series, :file, :allow_comments, :featured


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
	        	f.input :group
	        	f.input :series
	        end
	        f.inputs "Author" do
	          f.input :author
	          # f.has_many :authors do |author|
	          #    author.inputs
	          # end
	        end
          # f.inputs 'Publication' do
          # 	f.input :publishers
          # 	f.has_many :publishers do |author|
          # 	   author.inputs
          # 	end
          #   f.input :publication_date
          # end
	        f.inputs 'Cover Image' do
	        	# f.input :file
	        	# f.input :photo, hint: f.article.photo? ? image_tag(f.article.photo.url, height: '200') : content_tag(:span, "Upload JPG/PNG/GIF image")
	        	f.input :cover_img
	        end
	        f.inputs 'Publish Status' do
	        	f.input :draft, :label => "Make this a draft?"
	        	f.input :featured
	        	f.input :allow_comments, :label => "Allow commenting on this article?"
	        end
	      end
	    end
	f.actions
end

end
