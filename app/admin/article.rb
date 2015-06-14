ActiveAdmin.register Article do
		permit_params :author_ids, :publisher_ids, :publishers_attributes, :featured, :title, :cover_img, :file, :content, :group, :series, :language, :reads, :publication_date, :draft, :allow_comments, authors_attributes:  [ :id, :name, :first_name, :last_name, :brief_biography ], publishers_attributes: [ :name, :id ]
		
	sidebar "Author", :only => :show do
	    table_for(Article.find(params[:id]).authors) do
	    	column("Name") {|author| link_to "#{author.name}", admin_author_path(author) }
	    end
	end

	sidebar "Publisher", :only => :show do
	    table_for(Article.find(params[:id]).publishers) do
	    	column("Name") {|publisher| link_to "#{publisher.name}", admin_publisher_path(publisher) }
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
		column :title
		column :language
		column :series
		column :group
		column :draft, :sortable => :draft do |book|
	      status_tag((book.draft? ? "Not Published" : "Published"), (book.draft? ? :warning : :ok))
	    end
		column :featured
		column :cover_img
		# attachment_column :file
		column :created_at
	  actions
	end

	index as: :blog do
	  title :title # Calls #my_title on each resource
	  body  :content  # Calls #my_body on each resource
	end
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
	        	f.input :languages
	        	f.has_many :languages do |language|
	        	   language.inputs
	        	end
	        	f.input :groups
	        	f.has_many :groups do |group|
	        	   group.inputs
	        	end
	        	f.input :series
	        end
	        f.inputs "Author" do
	          f.input :authors
	          f.has_many :authors do |author|
	             author.inputs
	          end
	        end
          f.inputs 'Publication' do
          	f.input :publishers
          	f.has_many :publishers do |author|
          	   author.inputs
          	end
            f.input :publication_date
          end
	        f.inputs 'Actual Files' do
	        	f.input :file
	        	# f.input :photo, hint: f.article.photo? ? image_tag(f.article.photo.url, height: '200') : content_tag(:span, "Upload JPG/PNG/GIF image")
	        	f.input :cover_img
	        end
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
			@existing_authors = params[:article].delete("author_ids")
			@existing_publishers = params[:article].delete("publisher_ids")
			if @existing_authors
				@article.authors << Author.where(id: @existing_authors)
			end
			if @existing_publishers
				@article.publishers << Publisher.where(id: @existing_publishers)
			end

		end
	end

	def update
		super do |format|
			params.permit!
			@existing_authors = params[:article].delete("author_ids")
			@existing_publishers = params[:article].delete("publisher_ids")
			if @existing_authors
				@article.authors << Author.where(id: @existing_authors)
			end
			if @existing_publishers
				# @article.publishers.clear
				@article.publishers << Publisher.where(id:  @existing_publishers)
			end
		end
	end

end


end
