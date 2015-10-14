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
  	    row :format
  	    row "Description" do
  	    	if retreat_talk.description
	  	    	text_node (retreat_talk.description).html_safe
	  	    else
	  	    	para 'no description'
	  	    end
  	    end
  	    row "Audio (from embeded audio link)" do
  	    	if retreat_talk.audios.first
		  	    text_node (retreat_talk.audios.first.embeded_audio_link_strip).html_safe
		  	  end
  	    end
  	    row "Book related" do
  	    	if retreat_talk.books.first
  	    		if retreat_talk.books.first.file_file_name
		  	    	text_node ("<iframe src='" + retreat_talk.books.first.file.url + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
		  	    else
		  	    	text_node ("<iframe src='" + retreat_talk.books.first.external_file_link + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
		  	    end
		  	  end
  	    end
  	    # row "File" do
  	    # 	if retreat_talk.file_file_name
	  	   #  	text_node ("<iframe src='" + retreat_talk.file.url + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
	  	   #  else
	  	   #  	text_node ("<iframe src='" + retreat_talk.external_file_link + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
	  	   #  end
  	    # end
  	  end
  end
  # panel "retreat_talk Details" do
  # 	attributes_table_for retreat_talk do
  # 	  end
  # end
  panel "Status" do
  	attributes_table_for retreat_talk do
  	    row 'allow_comments' do
  	    	status_tag((retreat_talk.allow_comments? ? "Commenting Allowed" : "No Commenting Allowed"), (retreat_talk.allow_comments? ? :ok : :warning))
  	    end
  	    row 'featured' do
  	    	status_tag((retreat_talk.featured? ? "Featured" : "Not Featured"), (retreat_talk.featured? ? :ok : :warning))
  	    end
  	    row 'recommended' do
  	    	status_tag((retreat_talk.recommended? ? "Recommended" : "Not Recommended"), (retreat_talk.recommended? ? :ok : :warning))
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
	    # row :external_url_link do
	    # 	a retreat_talk.external_url_link, :href => retreat_talk.external_url_link
	    # end
	    row 'external_cover_img_link' do
	    	a retreat_talk.external_cover_img_link, :href => retreat_talk.external_cover_img_link
	    end
	    # row 'external_file_link' do
	    # 	a retreat_talk.external_file_link, :href => retreat_talk.external_file_link
	    # end
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
sidebar "Book", :only => :show do
	table_for(retreat_talk.books) do
		column("Title") {|book| link_to "#{book.title}", admin_book_path(book) }
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

index do
	selectable_column
	id_column
	column "audio", :sortable => false do |retreat_talk|
	  (retreat_talk.audios.first.embeded_audio_link_strip).html_safe
	end
	column :title
	column :retreat_talk_code
	column :series
	column :creation_date
	column :authors_related do |retreat_talk|
			retreat_talk.authors.each do |author|
				a :href => admin_author_path(author) do
					li author.name
				end
			end
	end
	column :books_related do |retreat_talk|
			retreat_talk.books.each do |book|
				a :href => admin_book_path(book) do
					li book.title
				end
			end
	end
	column :draft, :sortable => :draft do |retreat_talk|
      status_tag((retreat_talk.draft? ? "Not Published" : "Published"), (retreat_talk.draft? ? :warning : :ok))
    end
	column :featured
	# column :created_at
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
				# f.input :audio_code
				f.input :description, :required => true, :as => :ckeditor, :input_html => { :ckeditor => { :height => 400 } }
				f.input :languages
				f.has_many :languages do |language|
					language.inputs
				end
				f.input :series
				f.input :format
				f.input :groups
				f.has_many :groups do |group|
					group.input :name, :required => true
				end
				# f.input :external_url_link, :as => :url
				f.input :publication_date
			end
			f.inputs "Author" do
				f.input :authors
				f.has_many :authors do |author|
					author.input :name, :required => true
				end
			end
			f.inputs "Audio related to this book" do
        f.input :audios
        # f.has_many :audios do |audio|
        # 	audio.input :languages, :required => true, hint: content_tag(:span, "Must Select At Least One")
        # 	audio.input :admin_user_id, :as => :hidden
        # end
	    end
			f.inputs "Book related to this retreat_talk" do
	          f.input :books
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

	  	audios = @_params[:retreat_talk][:audios_attributes]
	  	if audios != nil
	  		audios.each do |k,v|
		  		if Language.where(id: v[:language_ids]) && (Audio.find_by title: v[:title])
				  	(Audio.find_by title: v[:title]).languages << Language.where(id: v[:language_ids])
				  else
				  	break
				  end
		  	end
		  end
	  end

	  controller do
	  	def create
	  		super do |format|
	  			params.permit!
	  			@existing_authors = params[:retreat_talk].delete("author_ids")
	  			@existing_books = params[:retreat_talk].delete("book_ids")
					@existing_audios = params[:retreat_talk].delete("audio_ids")	  			
	  			@existing_languages = params[:retreat_talk].delete("language_ids")
	  			@existing_groups = params[:retreat_talk].delete("group_ids")
	  			if @existing_authors
	  				@retreat_talk.authors << Author.where(id: @existing_authors)
	  			end
	  			if @existing_books
	  				@retreat_talk.books << Book.where(id: @existing_books)
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
			@existing_books = params[:retreat_talk].delete("book_ids")
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

			if @existing_books
				@retreat_talk.books = Book.where(id: @existing_books)
			end
			if params[:retreat_talk][:books_attributes]
				params[:retreat_talk][:books_attributes].each do |key, book|
					if !book.has_key?("id")
						new_book = Book.where(title: book[:title]).first_or_create
						@retreat_talk.books << new_book
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
