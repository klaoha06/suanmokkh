ActiveAdmin.register Group do
	permit_params :name, :date, :id, :external_cover_img_link


	belongs_to :book, optional: true
	belongs_to :article, optional: true
	belongs_to :audio, optional: true

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
  column :name
  column :number_of_languages do |group|
    a group.languages.count, :href => admin_languages_path()
  end
  column :number_of_audios do |group|
    a group.audios.count, :href => admin_audios_path()
  end
  # column :number_of_articles do |group|
  #     a group.articles.count, :href => admin_articles_path()
  # end
  # column :number_of_news_articles do |group|
  #   a group.news_articles.count, :href => admin_news_articles_path()
  # end
  column :number_of_poems do |group|
    a group.poems.count, :href => admin_poems_path()
  end
  column :created_at
  actions
end

form :html => { :enctype => "multipart/form-data" } do |f|
	tabs do
	      tab 'Basic' do
	        f.inputs 'Basic Details' do
	        	f.input :name, :required => true
	        	f.input :languages
	        	f.has_many :languages do |language|
	        	   language.inputs
	        	end
	        end
	        f.inputs "Books" do
	          f.input :books
	        end
	        f.inputs "Audios" do
	          f.input :audios
	        end
	        f.inputs "Poems" do
	          f.input :poems
	        end
	        # f.inputs "Articles" do
	        #   f.input :articles
	        # end
	        f.inputs 'Cover Image' do
	        	# f.input :file
	        	# f.input :photo, hint: f.article.photo? ? image_tag(f.article.photo.url, height: '200') : content_tag(:span, "Upload JPG/PNG/GIF image")
	        	f.input :cover_img
	        end
	      end
	    end
	f.actions
end


end
