ActiveAdmin.register Audio do
	# menu priority: 3
	config.per_page = 15
	permit_params :id, :admin_user_id, :recommended,
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

show do |audio|
  panel "Basic" do
  	attributes_table_for audio do
  	    row :title
  	    row :audio_code
  	    row :external_link
  	    row :created_at
  	    row :updated_at
  	    row :series
  	    row :creation_date
  	    row "Description" do
  	    	if audio.description
	  	    	text_node (audio.description).html_safe
  	    	end
  	    end
  	    row "Audio (from embeded audio link)" do
  	    	if audio.secret_uri
		  	    text_node ("<iframe width='100%' height='150' scrolling='no' frameborder='no' src='https://w.soundcloud.com/player/?url=" + audio.secret_uri + "&amp;color=725843&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false&amp;show_user=false></iframe>").html_safe
		  	  end
  	    end
  	  end
  end
  panel "Audio Details" do
  	attributes_table_for audio do
  	    row :duration
  	  end
  end
  panel "Status" do
  	attributes_table_for audio do
  	    row 'allow_comments' do
  	    	status_tag((audio.allow_comments? ? "No Commenting Allowed" : "Allowed Commenting"), (audio.allow_comments? ? :warning : :ok))
  	    end
  	    row 'featured' do
  	    	status_tag((audio.featured? ? "Not Featured" : "Featured"), (audio.featured? ? :warning : :ok))
  	    end
  	    row 'recommended' do
  	    	status_tag((audio.recommended? ? "Not recommended" : "Recommended"), (audio.recommended? ? :warning : :ok))
  	    end
  	    row 'draft' do
  	    	status_tag((audio.draft? ? "Not Published" : "Published"), (audio.draft? ? :warning : :ok))
  	    end
  	  end
  end
  # panel "Stats" do
  # 	attributes_table_for audio do
  # 	    row :plays
  # 	    row :shares
  # 	    # row :downloads
  # 	  end
  # end
  panel "External Links" do
  	attributes_table_for audio do
	    row :embeded_audio_link
	    row :external_url_link do
	    	a audio.external_link, :href => audio.external_link
	    end
	    # row 'external_file_link' do
	    # 	a book.external_file_link, :href => book.external_file_link
	    # end
	  end
  end
  # panel "File" do
  # 	attributes_table_for audio do
  # 	    attachment_row:file
  # 	    row :file_file_name
  # 	    row :file_content_type
  # 	    row 'file size (in Megabytes)' do
  # 	    	para number_to_human_size(audio.file_file_size)
  # 	    end
  # 	    row 'file url' do
  # 	    	para audio.file.url
  # 	    end
  # 	    row :file_updated_at
  # 	  end
  # end
	  # panel "Cover Image" do
	  # 	attributes_table_for audio do
	  # 	    attachment_row:cover_img
	  # 	    row :cover_img_file_name
	  # 	    row :cover_img_content_type
	  # 	    row 'cover image size (in Megabytes)' do
	  # 	    	para number_to_human_size(audio.cover_img_file_size)
	  # 	    end
	  # 	    row 'cover image url' do
	  # 	    	para audio.cover_img.url
	  # 	    end
	  # 	    row :cover_img_updated_at
	  # 	  end
	  # end
  active_admin_comments
end
	sidebar "Admin who create this audio..", :only => :show do
		if Audio.find(params[:id]).admin_user_id
			table_for(AdminUser.find(Audio.find(params[:id]).admin_user_id)) do
				column("") {|admin_user| link_to admin_user.email, admin_admin_user_path(admin_user) }
			end
		end
	end
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
	scope :published do |audio|
	  audio.where(:draft => false)
	end
	scope :not_published do |audio|
	  audio.where(:draft => true)
	end
	# scope :related_to_book do |audio|
	#   audio.where(:draft => true)
	# end

	index do
		selectable_column
		id_column
		column "audio", :sortable => false do |audio|
			text_node (audio.embeded_audio_link_strip).html_safe
			# <iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/222701360%3Fsecret_token%3Ds-x3YEY&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false"></iframe>
		end
		column :title
		column :audio_code
		column :series
		column :creation_date
		column :authors_related do |audio|
				audio.authors.each do |author|
					a :href => admin_author_path(author) do
						li author.name
					end
				end
		end
		column :books_related do |audio|
				audio.books.each do |book|
					a :href => admin_book_path(book) do
						li book.title
					end
				end
		end
		column :draft, :sortable => :draft do |audio|
	      status_tag((audio.draft? ? "Not Published" : "Published"), (audio.draft? ? :warning : :ok))
	    end
		column :featured
		# column :created_at
	  actions
	end

	form :html => { :enctype => "multipart/form-data" } do |f|
		tabs do
		      tab 'Basic' do
		        f.inputs 'Basic Details' do
		        	f.input :title, :required => true
		        	f.input :audio_code
		        	f.input :description, :as => :ckeditor, :input_html => { :ckeditor => { :height => 400 } }
		        	f.input :languages, :required => true
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
		          f.input :embeded_audio_link, :as => :url, :required => true, hint: content_tag(:span, "Please input an embededable code to direct be injected into the website.")
		          f.input :external_link, :as => :url, hint: content_tag(:span, "This will show just a link for user to click")
		        end
		        f.inputs "Author" do
		          f.input :authors
		          f.has_many :authors do |author|
		             author.input :name
		          end
		        end
		        f.inputs "Book relating to this audio.." do
		          f.input :books, hint: content_tag(:span, "To create new book please create this audio first then click on 'Books' tab on the top navigation bar and click on 'New Book' on the right. If this book is related to an book then create this book and find this book under the section 'Audio related to this book' in the book cretion form")
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
		        	f.input :recommended
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
				@audio.admin_user_id = @current_admin_user.id
				@current_admin_user.audios << @audio
				@current_admin_user.save()
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
