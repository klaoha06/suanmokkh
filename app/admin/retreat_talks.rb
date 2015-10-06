ActiveAdmin.register RetreatTalk do
	menu priority: 3
	config.per_page = 12
	permit_params :recommended, :language_ids, :admin_user_id, :group_ids, :author_ids, :audio_ids, :id, :external_url_link, :external_file_link, :external_cover_img_link, :title, :cover_img, :description, :downloads, :draft, :series, :allow_comments, :publication_date, :format, :featured, authors_attributes:  [ :id, :name, :first_name, :last_name, :brief_biography ], languages_attributes: [ :name, :id ], groups_attributes: [ :name, :id ], audios_attributes: [ :id, :title, :embeded_audio_link, :admin_user_id ]
	# config.batch_actions = true

show do |retreat_talk|
  panel "Basic" do
  	attributes_table_for retreat_talk do
  	    row :title
  	    row :created_at
  	    row :updated_at
  	    row :series
  	    row "Description" do
  	    	if retreat_talk.description
	  	    	text_node (retreat_talk.description).html_safe
	  	    else
	  	    	para 'no description'
	  	    end
  	    end
  	    row "File" do
  	    	if retreat_talk.file_file_name
	  	    	text_node ("<iframe src='" + retreat_talk.file.url + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
	  	    else
	  	    	text_node ("<iframe src='" + retreat_talk.external_file_link + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
	  	    end
  	    end
  	  end
  end
  panel "retreat_talk Details" do
  	attributes_table_for retreat_talk do
  	    row :format
  	  end
  end
  panel "Status" do
  	attributes_table_for retreat_talk do
  	    row 'allow_comments' do
  	    	status_tag((retreat_talk.allow_comments? ? "No Commenting Allowed" : "Allowed Commenting"), (retreat_talk.allow_comments? ? :warning : :ok))
  	    end
  	    row 'featured' do
  	    	status_tag((retreat_talk.featured? ? "Not Featured" : "Featured"), (retreat_talk.featured? ? :warning : :ok))
  	    end
  	    row 'recommended' do
  	    	status_tag((retreat_talk.recommended? ? "Not recommended" : "Recommended"), (retreat_talk.recommended? ? :warning : :ok))
  	    end
  	    row 'draft' do
  	    	status_tag((retreat_talk.draft? ? "Not Published" : "Published"), (retreat_talk.draft? ? :warning : :ok))
  	    end
  	  end
  end
  panel "Publication" do
  	attributes_table_for retreat_talk do
  	    row :publication_date
  	  end
  end
  panel "Stats" do
  	attributes_table_for retreat_talk do
  	    row :views
  	    row :shares
  	    row :downloads
  	  end
  end
  panel "External Links" do
  	attributes_table_for retreat_talk do
	    row :external_url_link do
	    	a retreat_talk.external_url_link, :href => retreat_talk.external_url_link
	    end
	    row 'external_cover_img_link' do
	    	a retreat_talk.external_cover_img_link, :href => retreat_talk.external_cover_img_link
	    end
	    row 'external_file_link' do
	    	a retreat_talk.external_file_link, :href => retreat_talk.external_file_link
	    end
	  end
  end

	 if retreat_talk.cover_img_file_name
	  panel "Cover Image" do
	  	attributes_table_for retreat_talk do
		  		row 'cover image preview' do
			  		image_tag(retreat_talk.cover_img, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img') if retreat_talk.cover_img_file_name
		  		end
	  	    attachment_row:cover_img
	  	    row :cover_img_file_name
	  	    row :cover_img_content_type
	  	    row 'cover image size (in Megabytes)' do
	  	    	para number_to_human_size(retreat_talk.cover_img_file_size)
	  	    end
	  	    row 'cover image url' do
	  	    	para retreat_talk.cover_img.url
	  	    end
	  	    row :cover_img_updated_at
	  	  end
		  end
		else
	 	panel "Cover Image" do
	 		attributes_table_for retreat_talk do
	  		row 'cover image preview' do
		  		image_tag(retreat_talk.external_cover_img_link, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img') if retreat_talk.external_cover_img_link
	  		end
	  		row 'external_cover_img_link' do
	  			a retreat_talk.external_cover_img_link.first(50), :href => retreat_talk.external_cover_img_link
	  		end
	 		end
	 	end
	 end
  active_admin_comments
end

sidebar "Admin who created this retreat_talk..", :only => :show do
	if retreat_talk.admin_user
		table_for(retreat_talk.admin_user) do
			column("") {|admin_user| link_to admin_user.email, admin_admin_user_path(admin_user) }
		end
	else
		para 'no creator'
	end
end
sidebar "Audio", :only => :show do
	table_for(retreat_talk.audios) do
		column("Title") {|audio| link_to "#{audio.title}", admin_audio_path(audio) }
	end
end
sidebar "Author", :only => :show do
	table_for(retreat_talk.authors) do
		column("Name") {|author| link_to "#{author.name}", admin_author_path(author) }
	end
end
sidebar "Language", :only => :show do
	table_for(retreat_talk.languages) do
		column("Name") {|language| link_to "#{language.name}", admin_language_path(language) }
	end
end
sidebar "Group", :only => :show do
	table_for(retreat_talk.groups) do
		column("Name") {|group| link_to "#{group.name}", admin_group_path(group) }
	end
end

scope :all, :default => true
scope :published do |products|
	products.where(:draft => false)
end
scope :not_published do |products|
	products.where(:draft => true)
end
scope :featured do |products|
	products.where(:featured => true)
end

index as: :grid, columns: 3 do |retreat_talk|
  panel retreat_talk.title do
  	if retreat_talk.cover_img_file_name
	  	a :href => admin_retreat_talk_path(retreat_talk) do
		  		image_tag(retreat_talk.cover_img, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img')
  		end
  	else
	  	a :href => admin_retreat_talk_path(retreat_talk) do
		  		image_tag(retreat_talk.external_cover_img_link, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img')
  		end
  	end
  	div :style => 'display:inline; text-align:center; padding: 5px;' do
  		attributes_table_for retreat_talk do
  		  row :title, :style => "font-size: 1.3em; font-weight:bold;"
  		  row 'Authors' do
  		    retreat_talk.authors.each do |author|
  		      a author.name, href: admin_author_path(author)          
  		    end
  		  end
  		  if retreat_talk.languages.length > 0
	  		  row 'Language' do
	  		    retreat_talk.languages.each do |language|
	  		      a language.name, href: admin_language_path(language)          
	  		    end
	  		  end
	  		end
  		  row("Created At", :sortable => :created_at){ pretty_format(retreat_talk.created_at) }
  		  if retreat_talk.file_file_name
	  		  attachment_row :file
	  		else
	  			row 'external_file_link' do
	  				a retreat_talk.external_file_link.first(50), href: retreat_talk.external_file_link         
	  			end
	  		end
	 #  retreat_talk.authors.each do |author|
		#   a truncate(author.name), :href => admin_author_path(author), :style => 'display:block; text-align:center; font-size:1em;'
		end
		a ' Show ', :href => admin_retreat_talk_path(retreat_talk), :class => "button"
		a ' Edit ', :href => '/admin/retreat_talks/' + retreat_talk.id.to_s + '/edit', :class => "button"
		text_node ("<a class='delete_link member_link button' data-confirm='Are you sure you want to delete this?' rel='nofollow' data-method='delete' href='/admin/retreat_talks/" + retreat_talk.id.to_s + "'>Delete</a>").html_safe
	end
  end
end

index do
	selectable_column
	id_column
	column "cover_img", :sortable => false do |retreat_talk|
		if retreat_talk.cover_img_file_name
		  "<img src='#{retreat_talk.cover_img.url}' alt='retreat_talk cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe
		else
		  "<img src='#{retreat_talk.external_cover_img_link}' alt='retreat_talk cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe
		 end
	end
	column :title
	column :file_source do |retreat_talk|
		a retreat_talk.file.url.first(30), :href => retreat_talk.file.url if retreat_talk.file.url
		a retreat_talk.external_file_link.first(30), :href => retreat_talk.external_file_link if retreat_talk.external_file_link
	end
		# attachment_column :file
	column :groups do |retreat_talk|
			retreat_talk.groups.each do |group|
				a :href => admin_group_path(group) do
					li group.name
				end
			end
	end
	column :languages do |retreat_talk|
			retreat_talk.languages.each do |language|
				a :href => admin_language_path(language) do
					li language.name
				end
			end
	end
	column :authors do |retreat_talk|
			retreat_talk.authors.each do |author|
				a :href => admin_author_path(author) do
					li author.name
				end
			end
	end
	column :audios_related do |retreat_talk|
			retreat_talk.audios.each do |audio|
				a :href => admin_audio_path(audio) do
					li audio.title
				end
			end
	end
	column :draft, :sortable => :draft do |retreat_talk|
		status_tag((retreat_talk.draft? ? "Not Published" : "Published"), (retreat_talk.draft? ? :warning : :ok))
	end
	column :featured
	column :created_at
	actions
end

# index as: :blog do
#   title :title # Calls #my_title on each resource
#   body  :description  # Calls #my_body on each resource
# end
form :html => { :enctype => "multipart/form-data" } do |f|
	tabs do
		tab 'Basic' do
			f.inputs 'Basic Details' do
				f.input :title, :required => true
				f.input :description, :required => true, :as => :ckeditor, :input_html => { :ckeditor => { :height => 400 } }
				f.input :languages
				f.has_many :languages do |language|
					language.inputs
				end
				f.input :series
				f.input :groups
				f.has_many :groups do |group|
					group.input :name, :required => true
				end
				f.input :external_url_link, :as => :url
			end
			f.inputs "Author" do
				f.input :authors
				f.has_many :authors do |author|
					author.input :name, :required => true
				end
			end
			f.inputs "Audio related to this retreat_talk.." do
	          f.input :audios
	          f.has_many :audios do |audio|
	             audio.input :title
	             audio.input :admin_user_id, :as => :hidden
	             audio.input :embeded_audio_link, :as => :url, :required => true, hint: content_tag(:span, "Copy the embeded audio link from soundcloud and paste it here..")
	          end
	        end
	        f.inputs 'retreat_talk Details' do
	        	f.input :format
	        end
	        f.inputs 'Publication Details' do
	        	f.input :publication_date
	        end
	        f.inputs 'Actual Files' do
	        	f.input :cover_img, :required => true, hint: f.retreat_talk.cover_img? ? image_tag(f.retreat_talk.cover_img.url, height: '150') : content_tag(:span, "Please choose ONLY between uploading the cover image here or give a link to the image file below in the external_cover_img_link")
	        	f.input :external_cover_img_link, :as => :url
	        end
	        f.inputs 'Post Status' do
	        	f.input :draft, :label => "Make this a draft?"
	        	f.input :featured
	        	f.input :recommended
	        	f.input :allow_comments, :label => "Allow commenting on this retreat_talk?"
	        end
	      end

	      # tab 'Publication' do
	      #   f.inputs 'Publication Details' do
	      #   	f.input :publishers
	      #   	# f.has_many :publishers do |author|
	      #   	#    author.inputs
	      #   	# end

	      #     f.input :isbn_10
	      #     f.input :isbn_13
	      #     f.input :publication_date
	      #   end
	      # end
	    end
	    f.actions
	  end

	  after_create do
	  	@retreat_talk.audios.each do |audio|
	  		@current_admin_user.audios << audio
	  	end
	  end

	  controller do
	  	def create
	  		super do |format|
	  			params.permit!
	  			@existing_authors = params[:retreat_talk].delete("author_ids")
					@existing_audios = params[:retreat_talk].delete("audio_ids")	  			
	  			@existing_languages = params[:retreat_talk].delete("language_ids")
	  			@existing_groups = params[:retreat_talk].delete("group_ids")
	  			if @existing_authors
	  				@retreat_talk.authors << Author.where(id: @existing_authors)
	  			end
	  			if @existing_audios
	  				@retreat_talk.audios << Audio.where(id: @existing_audios)
	  			end
	  			if @existing_languages
	  				@retreat_talk.languages << Language.where(id: @existing_languages)
	  			end
	  			if @existing_groups
	  				@retreat_talk.groups << Group.where(id: @existing_groups)
	  			end

	  			@retreat_talk.admin_user = @current_admin_user
	  			@current_admin_user.retreat_talks << @retreat_talk

		end #super
	end #create

	def update
		super do |format|
			params.permit!
			@existing_authors = params[:retreat_talk].delete("author_ids")
			@existing_audios = params[:retreat_talk].delete("audio_ids")	  			
			@existing_languages = params[:retreat_talk].delete("language_ids")
			@existing_groups = params[:retreat_talk].delete("group_ids")
			if @existing_authors
				@retreat_talk.authors = Author.where(id: @existing_authors)
			end
			if params[:retreat_talk][:authors_attributes]
				params[:retreat_talk][:authors_attributes].each do |key, author|
					if !author.has_key?("id")
						new_author = Author.where(name: author[:name]).first_or_create
						@retreat_talk.authors << new_author
					end
				end
			end

			if @existing_audios
				@retreat_talk.audios = Audio.where(id: @existing_audios)
			end
			if params[:retreat_talk][:audios_attributes]
				params[:retreat_talk][:audios_attributes].each do |key, audio|
					if !audio.has_key?("id")
						new_audio = Audio.where(title: audio[:title]).first_or_create
						@retreat_talk.audios << new_audio
					end
				end
			end

			if @existing_languages
				@retreat_talk.languages = Language.where(id: @existing_languages)
			end
			if params[:retreat_talk][:languages_attributes]
				params[:retreat_talk][:languages_attributes].each do |key, language|
					if !language.has_key?("id")
						new_language = Language.where(name: language[:name]).first_or_create
						@retreat_talk.languages << new_language
					end
				end
			end

			if @existing_groups
				@retreat_talk.groups = Group.where(id: @existing_groups)
			end
			if params[:retreat_talk][:groups_attributes]
				params[:retreat_talk][:groups_attributes].each do |key, group|
					if !group.has_key?("id")
						new_group = Group.where(name: group[:name]).first_or_create
						@retreat_talk.groups << new_group
					end
				end 
			end

		end #super
	end #update

end # controller

end
