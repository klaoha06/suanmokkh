ActiveAdmin.register Article do
	menu priority: 31
	config.per_page = 15
	permit_params :recommended, :external_file_link, :external_url_link, :external_cover_img_link, :author_ids, :creation_date, :publisher_ids, :publishers_attributes, :featured, :title, :cover_img, :file, :content, :group, :series, :language, :reads, :publication_date, :draft, :allow_comments, authors_attributes:  [ :id, :name, :first_name, :last_name, :brief_biography ], publishers_attributes: [ :name, :id ], languages_attributes: [ :name, :id ], groups_attributes: [ :name, :id ]
	
	show do |article|
	  panel "Basic" do
	  	attributes_table_for article do
	  	    row :title
	  	    if article.content
		  	    row "content" do
		  	    	text_node (article.content).html_safe
		  	    end
		  	  end
		  	  row :created_at
		  	  row :updated_at
		  	  row :series
		  	  row :creation_date
	  	    # row "File" do
	  	    # 	if article.file_file_name
		  	   #  	text_node ("<iframe src='" + article.file.url + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
		  	   #  else
		  	   #  	text_node ("<iframe src='" + article.external_file_link + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
		  	   #  end
	  	    # end
	  	  end
	  end
	  panel "Status" do
	  	attributes_table_for article do
	  	row 'allow_comments' do
  	    	if article.allow_comments?
  	    		status_tag(:yes, label: 'Commenting Allowed')
	  	    else
	  	    	status_tag( :no, label: "No Commenting Allowed")
	  	    end
  	    end
  	    row 'featured' do
  	    	if article.featured?
  	    		status_tag(:yes, label: 'Featured')
	  	    else
	  	    	status_tag(:no, label: "Not Featured")
	  	    end
  	    end
  	    row 'recommended' do
  	    	if article.recommended?
  	    		status_tag(:yes, label: 'Recommended')
	  	    else
	  	    	status_tag(:no, label: "Not Recommended")
	  	    end
  	    end
  	    row 'draft' do
  	    	if article.draft?
  	    		status_tag(:no, label: 'Not Published')
	  	    else
	  	    	status_tag(:yes, label: "Published")
	  	    end
  	    end
	  	  end
	  end
	  panel "Stats" do
	  	attributes_table_for article do
	  	    row :views
	  	  end
	  end
	  panel "External Links" do
	  	attributes_table_for article do
  	    row :external_url_link do
  	    	a article.external_url_link, :href => article.external_url_link
  	    end
  	    row 'external_cover_img_link' do
  	    	a article.external_cover_img_link, :href => article.external_cover_img_link
  	    end
  	    row 'external_file_link' do
  	    	a article.external_file_link, :href => article.external_file_link
  	    end
  	  end
	  end
	  if article.file_file_name
		  panel "File" do
		  	attributes_table_for article do
		  	    attachment_row:file
		  	    row :file_file_name
		  	    row :file_content_type
		  	    row 'file size (in Megabytes)' do
		  	    	para number_to_human_size(article.file_file_size)
		  	    end
		  	    row 'file url' do
		  	    	para article.file.url
		  	    end
		  	    row :file_updated_at
		  	  end
		  end
		end
		if article.cover_img_file_name
		  panel "Cover Image" do
		  	attributes_table_for article do
  		  		row 'cover image preview' do
  			  		image_tag(article.cover_img, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img') if article.cover_img_file_name
  		  		end
		  	    attachment_row:cover_img
		  	    row :cover_img_file_name
		  	    row :cover_img_content_type
		  	    row 'cover image size (in Megabytes)' do
		  	    	para number_to_human_size(article.cover_img_file_size)
		  	    end
		  	    row 'cover image url' do
		  	    	para article.cover_img.url
		  	    end
		  	    row :cover_img_updated_at
		  	  end
		  end
		else
		 	panel "Cover Image" do
		 		attributes_table_for article do
		  		row 'cover image preview' do
			  		image_tag(article.external_cover_img_link, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img') if article.external_cover_img_link
		  		end
		  		row 'external_cover_img_link' do
		  			a article.external_cover_img_link.first(50), :href => article.external_cover_img_link
		  		end
		 		end
		 	end
		 end
	  active_admin_comments
	end

	sidebar "Admin who create this article..", :only => :show do
		if Article.find(params[:id]).admin_user_id
			table_for(AdminUser.find(Article.find(params[:id]).admin_user_id)) do
				column("") {|admin_user| link_to admin_user.email, admin_admin_user_path(admin_user) }
			end
		end
	end
	sidebar "Author", :only => :show do
	    table_for(Article.find(params[:id]).authors) do
	    	column("Name") {|author| link_to "#{author.name}", admin_author_path(author) }
	    end
	end
	sidebar "Group", :only => :show do
		table_for(Article.find(params[:id]).groups) do
			column("Name") {|group| link_to "#{group.name}", admin_group_path(group) }
		end
	end
	sidebar "Language", :only => :show do
		table_for(Article.find(params[:id]).languages) do
			column("Name") {|language| link_to "#{language.name}", admin_language_path(language) }
		end
	end
	sidebar "Publisher", :only => :show do
	    table_for(Article.find(params[:id]).publishers) do
	    	column("Name") {|publisher| link_to "#{publisher.name}", admin_publisher_path(publisher) }
	    end
	end

	scope :all, :default => true
	scope :published do |articles|
	  articles.where(:draft => false)
	end
	scope :not_published do |articles|
	  articles.where(:draft => true)
	end
	scope :featured do |articles|
	  articles.where(:featured => true)
	end



	index do
		selectable_column
		id_column
		column "cover_img", :sortable => false do |article|
			if article.cover_img_file_name
			  "<img src='#{article.cover_img.url}' alt='article cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe
			else
			  "<img src='#{article.external_cover_img_link}' alt='article cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe
			 end
		end
		column :title
		# if article.file_file_name
			# attachment_column :file
		# end
		# column :file do |article|
		# 	a article.file.url.first(30), :href => article.file.url if article.file.url
		# 	a article.external_file_link.first(30), :href => article.external_file_link if article.external_file_link
		# end
		column :languages do |article|
				article.languages.each do |language|
					a :href => admin_language_path(language) do
						li language.name
					end
				end
		end
		column :series
		column :groups do |article|
				article.groups.each do |group|
					a :href => admin_group_path(group) do
						li group.name
					end
				end
		end
		column :authors do |article|
				article.authors.each do |author|
					a :href => admin_author_path(author) do
						li author.name
					end
				end
		end
		column :draft, :sortable => :draft do |article|
	  	    if article.draft?
  	    		status_tag(:no, label: 'Not Published')
	  	    else
	  	    	status_tag(:yes, label: "Published")
	  	    end
	    end
		column :featured
		column :cover_img
		# attachment_column :file
		column :created_at
	  actions
	end

	# index as: :blog do
	#   title :title # Calls #my_title on each resource
	#   body  :content  # Calls #my_body on each resource
	# end
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
	        	f.input :external_url_link, :as => :url
	        	f.input :languages
	        	f.has_many :languages do |language|
	        	   language.input :name
	        	end
	        	f.input :groups
	        	f.has_many :groups do |group|
	        	   group.input :name
	        	end
	        	f.input :series
	        end
	        f.inputs "Author" do
	          f.input :authors
	          f.has_many :authors do |author|
	             author.input :name
	          end
	        end
          f.inputs 'Publication' do
          	f.input :publishers
          	f.has_many :publishers do |author|
          	   author.input :name
          	end
            f.input :publication_date
          end
	        f.inputs 'Actual Files' do
	        	f.input :file, hint: content_tag(:span, "Please choose ONLY between uploading the file here or give a link to the pdf/epub file below in the external_file_link")
	        	f.input :external_file_link, :as => :url
	        	f.input :cover_img, hint: content_tag(:span, "Please choose ONLY between uploading the cover image here or give a link to the image file below in the external_cover_img_link")
	        	f.input :external_cover_img_link, :as => :url
	        end
	        f.inputs 'Publish Status' do
	        	f.input :draft, :label => "Make this a draft?"
	        	f.input :featured
	        	f.input :recommended
	        	f.input :allow_comments, :label => "Allow commenting on this article?"
	        end
	      end
	    end
	f.actions
end

controller do

	def create
		super do |format|
			params.permit!
			@existing_authors = params[:article].delete("author_ids")
			@existing_publishers = params[:article].delete("publisher_ids")
			@existing_languages = params[:article].delete("language_ids")
			@existing_groups = params[:article].delete("group_ids")
			if @existing_authors
				@article.authors << Author.where(id: @existing_authors)
			end
			if @existing_publishers
				@article.publishers << Publisher.where(id: @existing_publishers)
			end
			if @existing_languages
				@article.languages << Language.where(id: @existing_languages)
			end
			if @existing_groups
				@article.groups << Group.where(id: @existing_groups)
			end
			@article.admin_user_id = @current_admin_user.id
			@current_admin_user.articles << @article
			@current_admin_user.save()
		end
	end

	def update
		super do |format|
			params.permit!
			@existing_authors = params[:article].delete("author_ids")
			@existing_publishers = params[:article].delete("publisher_ids")
			@existing_languages = params[:article].delete("language_ids")
			@existing_groups = params[:article].delete("group_ids")

			if @existing_authors
				@article.authors = Author.where(id: @existing_authors)
			end
			if params[:article][:authors_attributes]
				params[:article][:authors_attributes].each do |key, author|
					if !author.has_key?("id")
						new_author = Author.where(name: author[:name]).first_or_create
						@article.authors << new_author
					end
				end
			end

			if @existing_publishers
				@article.publishers = Publisher.where(id:  @existing_publishers)
			end
			if params[:article][:publishers_attributes]
				params[:article][:publishers_attributes].each do |key, publisher|
					if !publisher.has_key?("id")
						new_publisher = Publisher.where(name: publisher[:name]).first_or_create
						@article.publishers << new_publisher
					end
				end
			end

			if @existing_languages
				@article.languages = Language.where(id: @existing_languages)
			end
			if params[:article][:languages_attributes]
				params[:article][:languages_attributes].each do |key, language|
					if !language.has_key?("id")
						new_language = Language.where(name: language[:name]).first_or_create
						@article.languages << new_language
					end
				end
			end

			if @existing_groups
				@article.groups = Group.where(id: @existing_groups)
			end
			if params[:article][:groups_attributes]
				params[:article][:groups_attributes].each do |key, group|
					if !group.has_key?("id")
						new_group = Group.where(name: group[:name]).first_or_create
						@article.groups << new_group
					end
				end 
			end

		end
	end

end


end
