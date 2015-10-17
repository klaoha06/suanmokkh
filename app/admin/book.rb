ActiveAdmin.register Book do
	menu priority: 2
	config.per_page = 12
	permit_params :recommended, :currency, :language_ids, :admin_user_id, :group_ids, :author_ids, :audio_ids, :publisher_ids, :id, :external_url_link, :external_file_link, :external_cover_img_link, :title, :cover_img, :description, :isbn_10, :isbn_13, :downloads, :draft, :series, :file, :allow_comments, :weight, :pages, :publication_date, :format, :price, :featured, authors_attributes:  [ :id, :name, :first_name, :last_name, :brief_biography ], publishers_attributes: [ :name, :id ], languages_attributes: [ :name, :id ], groups_attributes: [ :name, :id ], audios_attributes: [ :id, :language_ids, :title, :embeded_audio_link, :admin_user_id ]
	# config.batch_actions = true

show do |book|
  panel "Basic" do
  	attributes_table_for book do
  	    row :title
  	    row :created_at
  	    row :updated_at
  	    row :series
  	    row :creation_date
  	    row "Description" do
  	    	if book.description
	  	    	text_node (book.description).html_safe
	  	    else
	  	    	para 'no description'
	  	    end
  	    end
  	    row "File" do
  	    	if book.file_file_name
	  	    	text_node ("<iframe src='" + book.file.url + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
	  	    else
	  	    	text_node ("<iframe src='" + book.external_file_link + "#view=fit' width='100%' height='1000px' border='0' style='border:none' scrolling='no'></iframe>").html_safe
	  	    end
  	    end
  	  end
  end
  panel "Book Details" do
  	attributes_table_for book do
  	    row :format
  	    row :weight
  	    row :pages
  	    row :price
  	    row :currency
  	  end
  end
  panel "Status" do
  	attributes_table_for book do
  	    row 'allow_comments' do
  	    	status_tag((book.allow_comments? ? "No Commenting Allowed" : "Allowed Commenting"), (book.allow_comments? ? :warning : :ok))
  	    end
  	    row 'featured' do
  	    	status_tag((book.featured? ? "Not Featured" : "Featured"), (book.featured? ? :warning : :ok))
  	    end
  	    row 'recommended' do
  	    	status_tag((book.recommended? ? "Not recommended" : "Recommended"), (book.recommended? ? :warning : :ok))
  	    end
  	    row 'draft' do
  	    	status_tag((book.draft? ? "Not Published" : "Published"), (book.draft? ? :warning : :ok))
  	    end
  	  end
  end
  panel "Publication" do
  	attributes_table_for book do
  	    row :publication_date
  	    row :isbn_10
  	    row :isbn_13
  	  end
  end
  panel "Stats" do
  	attributes_table_for book do
  	    row :views
  	    row :shares
  	    row :downloads
  	  end
  end
  panel "External Links" do
  	attributes_table_for book do
	    row :external_url_link do
	    	a book.external_url_link, :href => book.external_url_link
	    end
	    row 'external_cover_img_link' do
	    	a book.external_cover_img_link, :href => book.external_cover_img_link
	    end
	    row 'external_file_link' do
	    	a book.external_file_link, :href => book.external_file_link
	    end
	  end
  end
  if book.file_file_name
	  panel "File" do
	  	attributes_table_for book do
	  	    attachment_row:file
	  	    row :file_file_name
	  	    row :file_content_type
	  	    row 'file size (in Megabytes)' do
	  	    	para number_to_human_size(book.file_file_size)
	  	    end
	  	    row 'file url' do
	  	    	para book.file.url
	  	    end
	  	    row :file_updated_at
	  	  end
	  end
	 end
	 if book.cover_img_file_name
	  panel "Cover Image" do
	  	attributes_table_for book do
		  		row 'cover image preview' do
			  		image_tag(book.cover_img, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img') if book.cover_img_file_name
		  		end
	  	    attachment_row:cover_img
	  	    row :cover_img_file_name
	  	    row :cover_img_content_type
	  	    row 'cover image size (in Megabytes)' do
	  	    	para number_to_human_size(book.cover_img_file_size)
	  	    end
	  	    row 'cover image url' do
	  	    	para book.cover_img.url
	  	    end
	  	    row :cover_img_updated_at
	  	  end
		  end
		else
	 	panel "Cover Image" do
	 		attributes_table_for book do
	  		row 'cover image preview' do
		  		image_tag(book.external_cover_img_link, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img') if book.external_cover_img_link
	  		end
	  		row 'external_cover_img_link' do
	  			a book.external_cover_img_link.first(50), :href => book.external_cover_img_link
	  		end
	 		end
	 	end
	 end
  active_admin_comments
end

sidebar "Admin who created this book..", :only => :show do
	if book.admin_user
		table_for(book.admin_user) do
			column("") {|admin_user| link_to admin_user.email, admin_admin_user_path(admin_user) }
		end
	else
		para 'no creator'
	end
end
sidebar "Retreat Talk", :only => :show do
	table_for(book.retreat_talks) do
		column("Title") {|retreat_talk| link_to "#{retreat_talk.title}", admin_retreat_talk_path(retreat_talk) }
	end
end
sidebar "Audio", :only => :show do
	table_for(book.audios) do
		column("Title") {|audio| link_to "#{audio.title}", admin_audio_path(audio) }
	end
end
sidebar "Author", :only => :show do
	table_for(book.authors) do
		column("Name") {|author| link_to "#{author.name}", admin_author_path(author) }
	end
end
sidebar "Publisher", :only => :show do
	table_for(book.publishers) do
		column("Name") {|publisher| link_to "#{publisher.name}", admin_publisher_path(publisher) }
	end
end
sidebar "Language", :only => :show do
	table_for(book.languages) do
		column("Name") {|language| link_to "#{language.name}", admin_language_path(language) }
	end
end
sidebar "Group", :only => :show do
	table_for(book.groups) do
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

index as: :grid, columns: 3 do |book|
  panel book.title do
  	if book.cover_img_file_name
	  	a :href => admin_book_path(book) do
		  		image_tag(book.cover_img, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img')
  		end
  	else
	  	a :href => admin_book_path(book) do
		  		image_tag(book.external_cover_img_link, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img')
  		end
  	end
  	div :style => 'display:inline; text-align:center; padding: 5px;' do
  		attributes_table_for book do
  		  row :title, :style => "font-size: 1.3em; font-weight:bold;"
  		  row 'Authors' do
  		    book.authors.each do |author|
  		      a author.name, href: admin_author_path(author)          
  		    end
  		  end
  		  if book.languages.length > 0
	  		  row 'Language' do
	  		    book.languages.each do |language|
	  		      a language.name, href: admin_language_path(language)          
	  		    end
	  		  end
	  		end
  		  row("Created At", :sortable => :created_at){ pretty_format(book.created_at) }
  		  if book.file_file_name
	  		  attachment_row :file
	  		else
	  			row 'external_file_link' do
	  				a book.external_file_link.first(50), href: book.external_file_link         
	  			end
	  		end
	 #  book.authors.each do |author|
		#   a truncate(author.name), :href => admin_author_path(author), :style => 'display:block; text-align:center; font-size:1em;'
		end
		a ' Show ', :href => admin_book_path(book), :class => "button"
		a ' Edit ', :href => '/admin/books/' + book.id.to_s + '/edit', :class => "button"
		text_node ("<a class='delete_link member_link button' data-confirm='Are you sure you want to delete this?' rel='nofollow' data-method='delete' href='/admin/books/" + book.id.to_s + "'>Delete</a>").html_safe
	end
  end
end

index do
	selectable_column
	id_column
	column "cover_img", :sortable => false do |book|
		if book.cover_img_file_name
		  "<img src='#{book.cover_img.url}' alt='book cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe
		else
		  "<img src='#{book.external_cover_img_link}' alt='book cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe
		 end
	end
	column :title
	column :file_source do |book|
		a book.file.url.first(30), :href => book.file.url if book.file.url
		a book.external_file_link.first(30), :href => book.external_file_link if book.external_file_link
	end
		# attachment_column :file
	column :groups do |book|
			book.groups.each do |group|
				a :href => admin_group_path(group) do
					li group.name
				end
			end
	end
	column :languages do |book|
			book.languages.each do |language|
				a :href => admin_language_path(language) do
					li language.name
				end
			end
	end
	column :authors do |book|
			book.authors.each do |author|
				a :href => admin_author_path(author) do
					li author.name
				end
			end
	end
	column :audios_related do |book|
			book.audios.each do |audio|
				a :href => admin_audio_path(audio) do
					li audio.title
				end
			end
	end
	column :draft, :sortable => :draft do |book|
		status_tag((book.draft? ? "Not Published" : "Published"), (book.draft? ? :warning : :ok))
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
				f.input :creation_date
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
			f.inputs "Audio related to this book" do
	          f.input :audios
	          # f.has_many :audios do |audio|
	          #    audio.input :title, :required => true
	          #    audio.input :languages, :required => true, hint: content_tag(:span, "Must Select At Least One")
	          #    audio.input :admin_user_id, :as => :hidden
	          #    # audio.input :embeded_audio_link, :as => :url, :required => true, hint: content_tag(:span, "Copy the embeded audio link from soundcloud and paste it here..")
	          # end
	        end
      		f.inputs "Retreat Talk(s) related to this book" do
                f.input :retreat_talks
                # f.has_many :audios do |audio|
                #    audio.input :title
                #    audio.input :admin_user_id, :as => :hidden
                #    audio.input :embeded_audio_link, :as => :url, :required => true, hint: content_tag(:span, "Copy the embeded audio link from soundcloud and paste it here..")
                # end
              end
	        f.inputs 'Book Details' do
	        	f.input :format
	        	f.input :pages
	        	f.input :weight
	        	f.input :price
	        	f.input :currency
	        end
	        f.inputs 'Publication Details' do
	        	f.input :publishers
	        	f.has_many :publishers do |publisher|
	        		publisher.input :name
	        	end
	        	f.input :isbn_10
	        	f.input :isbn_13
	        	f.input :publication_date
	        end
	        f.inputs 'Actual Files' do
	        	f.input :file, :required => true, hint: f.book.file? ? link_to(f.book.file_file_name, f.book.file.url) : content_tag(:span, "Please choose ONLY between uploading the file here or give a link to the pdf/epub file below in the external_file_link")
	        	f.input :external_file_link, :as => :url
	        	f.input :cover_img, :required => true, hint: f.book.cover_img? ? image_tag(f.book.cover_img.url, height: '150') : content_tag(:span, "Please choose ONLY between uploading the cover image here or give a link to the image file below in the external_cover_img_link")
	        	f.input :external_cover_img_link, :as => :url
	        end
	        f.inputs 'Post Status' do
	        	f.input :draft, :label => "Make this a draft?"
	        	f.input :featured
	        	f.input :recommended
	        	f.input :allow_comments, :label => "Allow commenting on this book?"
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
	  	@book.audios.each do |audio|
	  		@current_admin_user.audios << audio
	  	end

	  	audios = @_params[:book][:audios_attributes]
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

	  before_create do	
		  	audios = @_params[:book][:audios_attributes]
		  	if audios != nil
			  	audios.each do |k,v|
			  		if !Language.where(id: v[:language_ids]) && !(Audio.find_by title: v[:title])
					  	break
					  end
			  	end
			  end
	  end #before_create

  controller do
	  	def create
	  		super do |format|
	  			params.permit!
	  			@existing_authors = params[:book].delete("author_ids")
	  			@existing_retreat_talks = params[:book].delete("retreat_talk_ids")
	  			@existing_audios = params[:book].delete("audio_ids")	  			
	  			@existing_publishers = params[:book].delete("publisher_ids")
	  			@existing_languages = params[:book].delete("language_ids")
	  			@existing_groups = params[:book].delete("group_ids")
	  			if @existing_authors
	  				@book.authors << Author.where(id: @existing_authors)
	  			end
	  			if @existing_retreat_talks
	  				@book.retreat_talks << RetreatTalk.where(id: @existing_retreat_talks)
	  			end
	  			if @existing_audios
	  				@book.audios << Audio.where(id: @existing_audios)
	  			end
	  			if @existing_publishers
	  				@book.publishers << Publisher.where(id: @existing_publishers)
	  			end
	  			if @existing_languages
	  				@book.languages << Language.where(id: @existing_languages)
	  			end
	  			if @existing_groups
	  				@book.groups << Group.where(id: @existing_groups)
	  			end

	  			@book.admin_user = @current_admin_user
	  			@current_admin_user.books << @book

				end #super
			end #create

	def update
		super do |format|
			params.permit!
			@existing_authors = params[:book].delete("author_ids")
			@existing_retreat_talks = params[:book].delete("retreat_talk_ids")
			@existing_audios = params[:book].delete("audio_ids")	  			
			@existing_publishers = params[:book].delete("publisher_ids")
			@existing_languages = params[:book].delete("language_ids")
			@existing_groups = params[:book].delete("group_ids")

			if @existing_authors
				@book.authors = Author.where(id: @existing_authors)
			end
			if params[:book][:authors_attributes]
				params[:book][:authors_attributes].each do |key, author|
					if !author.has_key?("id")
						new_author = Author.where(name: author[:name]).first_or_create
						@book.authors << new_author
					end
				end
			end

			if @existing_retreat_talks
				@book.retreat_talks = RetreatTalk.where(id: @existing_retreat_talks)
			end
			if params[:book][:retreat_talks_attributes]
				params[:book][:retreat_talks_attributes].each do |key, retreat_talk|
					if !retreat_talk.has_key?("id")
						new_retreat_talk = RetreatTalk.where(name: retreat_talk[:name]).first_or_create
						@book.retreat_talks << new_retreat_talk
					end
				end
			end

			if @existing_audios
				@book.audios = Audio.where(id: @existing_audios)
			end
			if params[:book][:audios_attributes]
				params[:book][:audios_attributes].each do |key, audio|
					if !audio.has_key?("id")
						new_audio = Audio.where(title: audio[:title]).first_or_create
						@book.audios << new_audio
					end
				end
			end

			if @existing_publishers
				@book.publishers = Publisher.where(id:  @existing_publishers)
			end
			if params[:book][:publishers_attributes]
				params[:book][:publishers_attributes].each do |key, publisher|
					if !publisher.has_key?("id")
						new_publisher = Publisher.where(name: publisher[:name]).first_or_create
						@book.publishers << new_publisher
					end
				end
			end

			if @existing_languages
				@book.languages = Language.where(id: @existing_languages)
			end
			if params[:book][:languages_attributes]
				params[:book][:languages_attributes].each do |key, language|
					if !language.has_key?("id")
						new_language = Language.where(name: language[:name]).first_or_create
						@book.languages << new_language
					end
				end
			end

			if @existing_groups
				@book.groups = Group.where(id: @existing_groups)
			end
			if params[:book][:groups_attributes]
				params[:book][:groups_attributes].each do |key, group|
					if !group.has_key?("id")
						new_group = Group.where(name: group[:name]).first_or_create
						@book.groups << new_group
					end
				end 
			end

		end #super
	end #update

end # controller

end
