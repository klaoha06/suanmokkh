ActiveAdmin.register Book do
	menu priority: 2
	permit_params :title, :cover_img, :publisher, :description, :group, :language, :isbn_10, :isbn_13, :downloads, :draft, :series, :file, :allow_comments, :weight, :pages, :publication_date, :format, :price, :featured, :author_ids, authors_attributes:  [ :id, :name, :first_name, :last_name, :brief_biography ]

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
sidebar "Author", :only => :show do
    table_for(book.authors) do
    	column("Name") {|author| link_to "#{author.name}", admin_author_path(author) }
    end
end

# sidebar "Publisher(s) Details", :only => :show do
#     table_for(book.publishers) do
#     	column("Name") {|publisher| link_to "#{publisher.name}", admin_publisher_path(publisher) }
#     end
# end

scope :all, :default => true
scope :published do |products|
  products.where(:draft => false)
end
scope :not_published do |products|
  products.where(:draft => true)
end
scope :featured_products do |products|
  products.where(:featured => true)
end

index as: :grid do |book|
  # link_to(book.file_file_name, book.file.url)
  # link_to image_tag(book.cover_img, width: '150'), admin_book_path(book)
  div do
    a :href => admin_book_path(book) do
      image_tag(book.cover_img, width: '150', height: '200',margin: '0 auto', display: 'block')
    end
  end
  a truncate(book.title), :href => admin_book_path(book)
end

index do
	selectable_column
	id_column
	image_column :cover_img, style: :thumb
	column :title
	# column :description
	column :language
	column :publisher
	column :series
	column :group
	column :isbn_10
	column :isbn_13
	column :price do |book|
      number_to_currency book.price
    end
	column :draft, :sortable => :draft do |book|
      status_tag((book.draft? ? "Not Published" : "Published"), (book.draft? ? :warning : :ok))
    end
	column :featured
	# column :cover_img
	# attachment_column :cover_img
	attachment_column :file
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
	        	f.input :language
	        	f.input :series
	        	f.input :group
	        end
	        f.inputs "Author" do
	          f.input :authors
	          f.has_many :authors do |author|
	             author.inputs
	          end
	        end
	        f.inputs 'Book Details' do
	        	f.input :format
	        	f.input :pages
	        	f.input :weight
	        	f.input :price
	        end
	        f.inputs 'Publication Details' do
	        	f.input :publisher
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
	        	f.input :draft
	        	f.input :featured
	        	f.input :allow_comments, :label => "Allow commenting on this book"
	        end
	      end

	      tab 'Publication' do
	        f.inputs 'Publication Details' do
	        	f.input :publisher
	          f.input :isbn_10
	          f.input :isbn_13
	          f.input :publication_date
	        end
	      end
	    end
	f.actions
end

controller do
	def create
		super do |format|
			params.permit!
			@existing_authors = params[:book].delete("author_ids")
			if @existing_authors
				@book.authors << Author.where(id: @existing_authors)
			end

		end
	end

	def update
		super do |format|
			params.permit!
			@existing_authors = params[:book].delete("author_ids")
			if @existing_authors
				@book.authors.clear
				@book.authors << Author.where(id: @existing_authors)
			end
		end
	end


end

end
