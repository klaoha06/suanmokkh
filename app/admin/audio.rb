ActiveAdmin.register Audio do
	# menu priority: 3
	config.per_page = 15
	permit_params :id, 
		:language_ids, :group_ids, :audio_code, :author_ids, :featured, :title, :cover_img, :description, :duration, :creation_date, :group, :plays, :downloads, :embeded_audio_link, :external_link, :series, :file, :draft, :allow_comments, :author_ids, :book_ids, authors_attributes:  [ :id, :name, :first_name, :last_name, :brief_biography ], languages_attributes: [ :name, :id], groups_attributes: [ :name, :id]

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
	sidebar "Book related to this audio", :only => :show do
	    table_for(Audio.find(params[:id]).books) do
	    	column("Name") {|book| link_to "#{book.title}", admin_book_path(book) }
	    end
	end
	sidebar "Author related to this audio", :only => :show do
	    table_for(Audio.find(params[:id]).authors) do
	    	column("Name") {|author| link_to "#{author.name}", admin_author_path(author) }
	    end
	end
	sidebar "Group related to this audio", :only => :show do
	    table_for(Audio.find(params[:id]).groups) do
	    	column("Name") {|group| link_to "#{group.name}", admin_group_path(group) }
	    end
	end
	sidebar "Language related to this audio", :only => :show do
	    table_for(Audio.find(params[:id]).languages) do
	    	column("Name") {|language| link_to "#{language.name}", admin_language_path(language) }
	    end
	end

	scope :all, :default => true
	scope :published do |products|
	  products.where(:draft => false)
	end
	scope :not_published do |products|
	  products.where(:draft => true)
	end

	index do
		selectable_column
		id_column
		column :audio_code
		# image_column :cover_img
		column :title
		# column :description
		column :series
		column :creation_date
		# column :authors do |audio|
		# 		audio.authors.each do |a|
		# 			content_tag(:li, a.name)
		# 		end
		# end
		column :draft, :sortable => :draft do |audio|
	      status_tag((audio.draft? ? "Not Published" : "Published"), (audio.draft? ? :warning : :ok))
	    end
		column :featured
		# column :cover_img
		# attachment_column :cover_img
		# attachment_column :file
		# column :file
		column :created_at
	  actions
	end

	form :html => { :enctype => "multipart/form-data" } do |f|
		tabs do
		      tab 'Basic' do
		        f.inputs 'Basic Details' do
		        	f.input :title, :required => true
		        	f.input :audio_code
		        	f.input :description, :as => :ckeditor, :input_html => { :ckeditor => { :height => 400 } }
		        	f.input :languages
		        	f.has_many :languages do |language|
		        	   language.inputs
		        	end
		        	f.input :groups
		        	f.has_many :groups do |group|
		        	   group.input :name
		        	end
		        	f.input :series
		        	f.input :creation_date
		        	f.input :duration
		        end
		        f.inputs "Links" do
		          f.input :embeded_audio_link, :required => true, hint: content_tag(:span, "Please input an embededable code to direct be injected into the website.")
		          f.input :external_link, hint: content_tag(:span, "This will show just a link for user to click")
		        end
		        f.inputs "Author" do
		          f.input :authors
		          f.has_many :authors do |author|
		             author.input :name
		          end
		        end
		        f.inputs "Book relating to this audio.." do
		          f.input :books, hint: content_tag(:span, "To create new book please click on 'Books' tab on the top navigation bar and click on 'New Book' on the right. If this book is related to an book then create this book and find this book under the section 'Audio related to this book' in the book cretion form")
		          # f.has_many :books do |book|
		          #    book.inputs
		          # end
		        end
		        # f.inputs 'Actual Files' do
		        # 	# f.input :file, hint: content_tag(:span, "DO NOT upload the file here unless necessary. Please use service like Soundcloud for uploading audio instead whenever possible.")
		        # end
		        f.inputs 'Publish Status' do
		        	f.input :draft, :label => "Make this a draft?"
		        	f.input :featured
		        	f.input :allow_comments, :label => "Allow commenting on this audio track?"
		        end
		      end
		    end
		f.actions
	end

	controller do

		def create
			super do |format|
				params.permit!
				@existing_authors = params[:audio].delete("author_ids")
				@existing_languages = params[:audio].delete("language_ids")
				@existing_groups = params[:audio].delete("group_ids")
				@existing_books = params[:audio].delete("book_ids")
				if @existing_authors
					@audio.authors << Author.where(id: @existing_authors)
				end
				if @existing_books
					@audio.books << Book.where(id: @existing_books)
				end
				if @existing_languages
					@audio.languages << Language.where(id: @existing_languages)
				end
				if @existing_groups
					@audio.groups << Group.where(id: @existing_groups)
				end
			end
		end

		def update
			super do |format|
				params.permit!
				@existing_authors = params[:audio].delete("author_ids")
				@existing_books = params[:audio].delete("book_ids")
				@existing_languages = params[:audio].delete("language_ids")
				@existing_groups = params[:audio].delete("group_ids")


				if @existing_authors
					@audio.authors = Author.where(id: @existing_authors)
				end
				if params[:audio][:authors_attributes]
					params[:audio][:authors_attributes].each do |key, author|
						if !author.has_key?("id")
							new_author = Author.where(name: author[:name]).first_or_create
							@audio.authors << new_author
						end
					end
				end

				if @existing_books
					@audio.books = Book.where(id:  @existing_books)
				end
				if params[:audio][:books_attributes]
					params[:audio][:books_attributes].each do |key, book|
						if !book.has_key?("id")
							new_book = Book.where(name: book[:name]).first_or_create
							@audio.books << new_book
						end
					end
				end

				if @existing_languages
					@audio.languages = Language.where(id: @existing_languages)
				end
				if params[:audio][:languages_attributes]
					params[:audio][:languages_attributes].each do |key, language|
						if !language.has_key?("id")
							new_language = Language.where(name: language[:name]).first_or_create
							@audio.languages << new_language
						end
					end
				end

				if @existing_groups
					@audio.groups = Group.where(id: @existing_groups)
				end
				if params[:audio][:groups_attributes]
					params[:audio][:groups_attributes].each do |key, group|
						if !group.has_key?("id")
							new_group = Group.where(name: group[:name]).first_or_create
							@audio.groups << new_group
						end
					end 
				end
			end #super
		end #update

	end


end
