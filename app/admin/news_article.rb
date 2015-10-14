# ActiveAdmin.register NewsArticle do
# 	config.per_page = 15

# 	permit_params :id, :title, :cover_img, :content, :views, :draft, :allow_comments, :featured, :author, languages_attributes: [ :name, :id ], groups_attributes: [ :name, :id ]

# 	show do |news_article|
# 	  panel "Basic" do
# 	  	attributes_table_for news_article do
# 	  	    row :title
# 	  	    row :created_at
# 	  	    row :updated_at
# 	  	    row :series
# 	  	    row "Content" do
# 	  	    	if news_article.content
# 		  	    	text_node (news_article.content).html_safe
# 	  	    	end
# 	  	    end
# 	  	  end
# 	  end
# 	  panel "Status" do
# 	  	attributes_table_for news_article do
# 	  	    row 'allow_comments' do
# 	  	    	status_tag((news_article.allow_comments? ? "No Commenting Allowed" : "Allowed Commenting"), (news_article.allow_comments? ? :warning : :ok))
# 	  	    end
# 	  	    row 'featured' do
# 	  	    	status_tag((news_article.featured? ? "Not Featured" : "Featured"), (news_article.featured? ? :warning : :ok))
# 	  	    end
# 	  	    row 'draft' do
# 	  	    	status_tag((news_article.draft? ? "Not Published" : "Published"), (news_article.draft? ? :warning : :ok))
# 	  	    end
# 	  	  end
# 	  end
# 	  panel "Stats" do
# 	  	attributes_table_for news_article do
# 	  	    row :views
# 	  	  end
# 	  end
# 	  if news_article.cover_img_file_name
# 		  panel "Cover Image" do
# 		  	attributes_table_for news_article do
# 		  	    attachment_row:cover_img
# 		  	    row :cover_img_file_name
# 		  	    row :cover_img_content_type
# 		  	    row 'cover image size (in Megabytes)' do
# 		  	    	para number_to_human_size(news_article.cover_img_file_size)
# 		  	    end
# 		  	    row 'cover image url' do
# 		  	    	para news_article.cover_img.url
# 		  	    end
# 		  	    row :cover_img_updated_at
# 		  	  end
# 		  end
# 		end
# 	  active_admin_comments
# 	end

# sidebar "Admin who created this news article..", :only => :show do
# 	if news_article.admin_user_id
# 		table_for(AdminUser.find(news_article.admin_user_id)) do
# 			column("") {|admin_user| link_to admin_user.email, admin_admin_user_path(admin_user) }
# 		end
# 	else
# 		para 'no creator'
# 	end
# end
# sidebar "Language", :only => :show do
# 	if news_article.languages.count > 0
# 		table_for(news_article.languages) do
# 			column("Name") {|language| link_to "#{language.name}", admin_language_path(language) }
# 		end
# 	else 
# 		para 'no input language'
# 	end
# end
# sidebar "Group", :only => :show do
# 	if news_article.groups.count > 0
# 		table_for(news_article.groups) do
# 			column("Name") {|group| link_to "#{group.name}", admin_group_path(group) }
# 		end
# 	else
# 		para 'no input group'
# 	end
# end

# index do
# 	selectable_column
# 	id_column
# 	column :title
# 	# column "cover_img", :sortable => false do |poem|
# 	#   poem.cover_img.url ? "<img src='#{poem.cover_img.url}' alt='poem cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe : 'no image'
# 	# end
# 	column :groups do |news_article|
# 			news_article.groups.each do |group|
# 				a :href => admin_group_path(group) do
# 					li group.name
# 				end
# 			end
# 	end
# 	column :languages do |news_article|
# 			news_article.languages.each do |language|
# 				a :href => admin_language_path(language) do
# 					li language.name
# 				end
# 			end
# 	end
# 	column :draft, :sortable => :draft do |news_article|
# 		status_tag((news_article.draft? ? "Not Published" : "Published"), (news_article.draft? ? :warning : :ok))
# 	end
# 	column :featured
# 	column :created_at
# 	column 'created by' do |news_article|
# 		admin = AdminUser.find(news_article.admin_user_id)
# 		a admin.email, :href => admin_admin_user_path(admin)
# 	end
# 	actions
# end

# form :html => { :enctype => "multipart/form-data" } do |f|
# 	tabs do
# 	      tab 'Basic' do
# 	        f.inputs 'Basic Details' do
# 	        	f.input :title, :required => true
# 	        	f.input :content, :as => :ckeditor, :input_html => { :ckeditor => { :height => 400 } }
# 	        	f.input :author
# 	        	f.input :languages
# 	        	f.has_many :languages do |l|
# 	        	   l.input :name
# 	        	end
# 	        	f.input :groups
# 	        	f.has_many :groups do |group|
# 	        	   group.input :name
# 	        	end
# 	        end
# 	        f.inputs 'Cover Image' do
# 	        	f.input :cover_img
# 	        end
# 	        f.inputs 'Publish Status' do
# 	        	f.input :draft, :label => "Make this a draft?"
# 	        	f.input :featured
# 	        	f.input :allow_comments, :label => "Allow commenting on this article?"
# 	        end
# 	      end
# 	    end
# 	f.actions
# end

# 	controller do
# 	  	def create
# 	  		super do |format|
# 	  			params.permit!
# 	  			@existing_languages = params[:news_article].delete("language_ids")
# 	  			@existing_groups = params[:news_article].delete("group_ids")
# 	  			if @existing_languages
# 	  				@news_article.languages << Language.where(id: @existing_languages)
# 	  			end
# 	  			if @existing_groups
# 	  				@news_article.groups << Group.where(id: @existing_groups)
# 	  			end
# 	  			@current_admin_user.news_articles << @news_article
# 	  			@current_admin_user.save()
# 		end #super
# 	end #create

# 	def update
# 		super do |format|
# 			params.permit!
# 			@existing_languages = params[:news_article].delete("language_ids")
# 			@existing_groups = params[:news_article].delete("group_ids")
# 			if @existing_languages
# 				@news_article.languages = Language.where(id: @existing_languages)
# 			end
# 			if params[:news_article][:languages_attributes]
# 				params[:news_article][:languages_attributes].each do |key, language|
# 					if !language.has_key?("id")
# 						new_language = Language.where(name: language[:name]).first_or_create
# 						@news_article.languages << new_language
# 					end
# 				end
# 			end

# 			if @existing_groups
# 				@news_article.groups = Group.where(id: @existing_groups)
# 			end
# 			if params[:news_article][:groups_attributes]
# 				params[:news_article][:groups_attributes].each do |key, group|
# 					if !group.has_key?("id")
# 						new_group = Group.where(name: group[:name]).first_or_create
# 						@news_article.groups << new_group
# 					end
# 				end 
# 			end

# 		end #super
# 	end #update

# end # controller


# end
