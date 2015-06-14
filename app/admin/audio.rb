ActiveAdmin.register Audio do
	# menu priority: 3
	permit_params :title, :cover_img, :description, :duration, :creation_date, :group, :language, :plays, :downloads, :embeded_audio_link, :external_link, :series, :file, :draft, :allow_comments, :author_ids, :book_ids, authors_attributes:  [ :id, :name, :first_name, :last_name, :brief_biography ]

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

	sidebar "Author", :only => :show do
	    table_for(Audio.find(params[:id]).authors) do
	    	column("Name") {|author| link_to "#{author.name}", admin_author_path(author) }
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
		# image_column :cover_img
		column :title
		column :description
		column :language
		column :publisher
		column :series
		column :group
		column :creation_date
		column :draft, :sortable => :draft do |book|
	      status_tag((book.draft? ? "Not Published" : "Published"), (book.draft? ? :warning : :ok))
	    end
		column :featured
		# column :cover_img
		# attachment_column :cover_img
		# attachment_column :file
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
		        	f.input :description, :as => :ckeditor, :input_html => { :ckeditor => { :height => 400 } }
		        	f.input :language
		        	f.input :group
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
		             author.inputs
		          end
		        end
		        f.inputs "Book relating to this audio.." do
		          f.input :books
		          f.has_many :books do |book|
		             book.inputs
		          end
		        end
		        # f.inputs 'Actual Files' do
		        # 	# f.input :file, hint: content_tag(:span, "DO NOT upload the file here unless necessary. Please use service like Soundcloud for uploading audio instead whenever possible.")
		        # end
		        f.inputs 'Publish Status' do
		        	f.input :draft, :label => "Make this a draft?"
		        	f.input :featured
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
				@existing_authors = params[:audio].delete("author_ids")
				if @existing_authors
					@audio.authors << Author.where(id: @existing_authors)
				end
			end
		end

		def update
			super do |format|
				params.permit!
				@existing_authors = params[:audio].delete("author_ids")
				if @existing_authors
					@audio.authors << Author.where(id: @existing_authors)
				end
			end
		end

	end


end
