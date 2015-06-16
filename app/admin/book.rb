ActiveAdmin.register Book do
	# menu priority: 2
	config.per_page = 12
	permit_params :language_ids, :group_ids, :author_ids, :audio_ids, :publisher_ids, :id, :external_file_link, :external_cover_img_link, :title, :cover_img, :description, :isbn_10, :isbn_13, :downloads, :draft, :series, :file, :allow_comments, :weight, :pages, :publication_date, :format, :price, :featured, authors_attributes:  [ :id, :name, :first_name, :last_name, :brief_biography ], publishers_attributes: [ :name, :id ], languages_attributes: [ :name, :id ], groups_attributes: [ :name, :id ], audios_attributes: [ :id, :title, :embeded_audio_link ]
	# config.batch_actions = true
	# belongs_to :publisher
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

# belongs_to :author

# ActiveAdmin.register Author do
#   belongs_to :book
#   navigation_menu :book
# end

# ActiveAdmin.register Publisher do
#   belongs_to :book
#   navigation_menu :book
# end

# show do
#   panel "Basic" do
#   	attributes_table_for book do
#   	    row :title
#   	    # row :author
#   	    # row :publisher
#   	    row('Published?') { |b| status_tag b.draft? }
#   	  end
#   end
#   panel "Author" do
#   	attributes_table_for book. do
#   	    row :title
#   	    # row :author
#   	    # row :publisher
#   	    row('Published?') { |b| status_tag b.draft? }
#   	  end
#   end
#   active_admin_comments
# end

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

index as: :grid, columns: 2 do |book|
  # link_to(book.file_file_name, book.file.url)
  # link_to image_tag(book.cover_img, width: '150'), admin_book_path(book)
  panel book.title do
  	a :href => admin_book_path(book) do
  		image_tag(book.cover_img, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img')
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
  		  attachment_row :file
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
	column :title
	column "cover_img", :sortable => false do |book|
	  "<img src='#{book.cover_img.url}' alt='book cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe
	end
	# image_column :cover_img
	# column :description
	# column :language
	# column :publisher
	# column :series
	# column :group
	# column :isbn_10
	# column :isbn_13
	# column :price do |book|
	# 	number_to_currency book.price
	# end
	# column :cover_img
	# attachment_column :cover_img
	attachment_column :file
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
				f.input :languages
				f.has_many :languages do |language|
					language.inputs
				end
				f.input :series
				f.input :groups
				f.has_many :groups do |group|
					group.input :name, :required => true
				end
			end
			f.inputs "Author" do
				f.input :authors
				f.has_many :authors do |author|
					author.input :name, :required => true
				end
			end
			f.inputs "Audio related to this book.." do
	          f.input :audios
	          f.has_many :audios do |audio|
	             audio.input :title
	             audio.input :embeded_audio_link, :required => true, hint: content_tag(:span, "Copy the embeded audio link from soundcloud and paste it here..")
	          end
	        end
	        f.inputs 'Book Details' do
	        	f.input :format
	        	f.input :pages
	        	f.input :weight
	        	f.input :price
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
	        	f.input :file, :required => true, hint: f.book.file? ? link_to(f.book.file_file_name, f.book.file.url) : content_tag(:span, "Upload PDF/EPUB file")
	        	# f.input :cover_img, :as => :file, :hint => image_tag(f.book.cover_img.url, height: '140') 
	        	# f.input :cover_img_cache, :as => :hidden 
	        	f.input :cover_img, :required => true, hint: f.book.cover_img? ? image_tag(f.book.cover_img.url, height: '150') : content_tag(:span, "Upload JPG/PNG/GIF image")
	        end
	        f.inputs 'Post Status' do
	        	f.input :draft, :label => "Make this a draft?"
	        	f.input :featured
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

	  controller do
	  	def create
	  		super do |format|
	  			params.permit!
	  			@existing_authors = params[:book].delete("author_ids")
					@existing_audios = params[:book].delete("audio_ids")	  			
	  			@existing_publishers = params[:book].delete("publisher_ids")
	  			@existing_languages = params[:book].delete("language_ids")
	  			@existing_groups = params[:book].delete("group_ids")
	  			if @existing_authors
	  				@book.authors << Author.where(id: @existing_authors)
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

		end #super
	end #create

	def update
		super do |format|
			params.permit!
			@existing_authors = params[:book].delete("author_ids")
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
