ActiveAdmin.register GalleryPhoto, as: "Gallery Photo" do
	permit_params :id

	form :html => { :enctype => "multipart/form-data" } do |f|
		tabs do
			tab 'Required Infomation' do
				f.input :img, :required => true, hint: f.gallery_photo.img? ? image_tag(f.gallery_photo.img.url, height: '150') : content_tag(:span, "Please choose ONLY between uploading the cover image here or give a link to the image file below in the external_cover_img_link")
				f.input :external_cover_img_link, :as => :url
			end
		end
	end
end