ActiveAdmin.register GalleryPhoto, as: "Gallery Photo" do
	permit_params :id, :external_img_link, :caption, :img

	form :html => { :enctype => "multipart/form-data" } do |f|
		tabs do
			tab 'Required Data' do
				f.inputs do
					f.input :img, :required => true, hint: f.gallery_photo.img? ? image_tag(f.gallery_photo.img.url, height: '150') : content_tag(:span, "Please choose ONLY between uploading the cover image here or give a link to the image file below in the external_img_link")
					# f.input :external_img_link, :as => :url
					f.input :caption, :required => true, :as => :ckeditor, :input_html => { :ckeditor => { :height => 400 } }
				end
			end
		end
		f.actions
	end

	show do |gallery_photo|
	  panel "Basic" do
	  	attributes_table_for gallery_photo do
	  	    row :id
	  	    row :created_at
	  	    row :updated_at
	  	    row "Caption" do
	  	    	if gallery_photo.caption
		  	    	text_node (gallery_photo.caption).html_safe
		  	    else
		  	    	para 'no description'
		  	    end
	  	    end
	  	    row "File" do
	  	    	if gallery_photo.img_file_name
		  	    	text_node ("<iframe src='" + gallery_photo.img.url + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
		  	    else
		  	    	text_node ("<iframe src='" + gallery_photo.external_img_link + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
		  	    end
	  	    end
	  	  end
		  end
		end

end