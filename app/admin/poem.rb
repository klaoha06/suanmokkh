ActiveAdmin.register Poem do
	config.per_page = 15

	permit_params :id, :title, :cover_img, :content, :group, :language, :draft, :series, :file, :allow_comments, :featured, :language_ids, :group_ids, :author_ids, authors_attributes:  [ :id, :name, :first_name, :last_name, :brief_biography ], languages_attributes: [ :name, :id ], groups_attributes: [ :name, :id ]


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

index as: :grid, columns: 3 do |poem|
  panel poem.title do
  	# a :href => admin_poem_path(poem) do
  	# 	image_tag(poem.cover_img, width: '150', height: '200',margin: '0 auto', display: 'block', class: 'grid_img')
  	# end
  	# para (poem.content).html_safe
  	div :style => 'display:inline; text-align:center; padding: 5px;' do
  		attributes_table_for poem do
  		  row :title, :style => "font-size: 1.3em; font-weight:bold;"
  		  row 'content' do
  		  	para (poem.content).html_safe
  		  end
  		  row 'Authors' do
  		    poem.authors.each do |author|
  		      a author.name, href: admin_author_path(author)          
  		    end
  		  end
  		  if poem.languages.length > 0
	  		  row 'Language' do
	  		    poem.languages.each do |language|
	  		      a language.name, href: admin_language_path(language)          
	  		    end
	  		  end
	  		end
  		  row("Created At", :sortable => :created_at){ pretty_format(poem.created_at) }
	 #  poem.authors.each do |author|
		#   a truncate(author.name), :href => admin_author_path(author), :style => 'display:block; text-align:center; font-size:1em;'
		end
		a ' Show ', :href => admin_poem_path(poem), :class => "button"
		a ' Edit ', :href => '/admin/poems/' + poem.id.to_s + '/edit', :class => "button"
		text_node ("<a class='delete_link member_link button' data-confirm='Are you sure you want to delete this?' rel='nofollow' data-method='delete' href='/admin/books/" + poem.id.to_s + "'>Delete</a>").html_safe
	end
  end
end

index do
	selectable_column
	id_column
	column :title
	# column "cover_img", :sortable => false do |poem|
	#   poem.cover_img.url ? "<img src='#{poem.cover_img.url}' alt='poem cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe : 'no image'
	# end
	column :groups do |poem|
			poem.groups.each do |group|
				a :href => admin_group_path(group) do
					li group.name
				end
			end
	end
	column :languages do |poem|
			poem.languages.each do |language|
				a :href => admin_language_path(language) do
					li language.name
				end
			end
	end
	column :authors_related do |poem|
			poem.authors.each do |author|
				a :href => admin_author_path(author) do
					li author.name
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

	sidebar "Admin who created this poem..", :only => :show do
		if poem.admin_user_id
			table_for(AdminUser.find(poem.admin_user_id)) do
				column("") {|admin_user| link_to admin_user.email, admin_admin_user_path(admin_user) }
			end
		else
			para 'no creator'
		end
	end
sidebar "Author", :only => :show do
	if poem.authors.count > 0
		table_for(poem.authors) do
			column("Name") {|author| link_to "#{author.name}", admin_author_path(author) }
		end
	else
		para 'no input author'
	end
end
sidebar "Language", :only => :show do
	if poem.languages.count > 0
		table_for(poem.languages) do
			column("Name") {|language| link_to "#{language.name}", admin_language_path(language) }
		end
	else 
		para 'no input language'
	end
end
sidebar "Group", :only => :show do
	if poem.groups.count > 0
		table_for(poem.groups) do
			column("Name") {|group| link_to "#{group.name}", admin_group_path(group) }
		end
	else
		para 'no input group'
	end
end

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
	        f.inputs 'Cover Image' do
	        	f.input :cover_img
	        end
	        f.inputs 'Publish Status' do
	        	f.input :draft, :label => "Make this a draft?"
	        	# f.input :featured
	        	# f.input :allow_comments, :label => "Allow commenting on this article?"
	        end
	      end
	    end
	f.actions
end

	controller do
	  	def create
	  		super do |format|
	  			params.permit!
	  			@existing_authors = params[:poem].delete("author_ids")
	  			@existing_languages = params[:poem].delete("language_ids")
	  			@existing_groups = params[:poem].delete("group_ids")
	  			if @existing_authors
	  				@poem.authors << Author.where(id: @existing_authors)
	  			end
	  			if @existing_languages
	  				@poem.languages << Language.where(id: @existing_languages)
	  			end
	  			if @existing_groups
	  				@poem.groups << Group.where(id: @existing_groups)
	  			end
	  			@current_admin_user.poems << @poem
	  			@current_admin_user.save()
		end #super
	end #create

	def update
		super do |format|
			params.permit!
			@existing_authors = params[:poem].delete("author_ids")
			@existing_languages = params[:poem].delete("language_ids")
			@existing_groups = params[:poem].delete("group_ids")

			if @existing_authors
				@poem.authors = Author.where(id: @existing_authors)
			end
			if params[:poem][:authors_attributes]
				params[:poem][:authors_attributes].each do |key, author|
					if !author.has_key?("id")
						new_author = Author.where(name: author[:name]).first_or_create
						@book.authors << new_author
					end
				end
			end

			if @existing_languages
				@poem.languages = Language.where(id: @existing_languages)
			end
			if params[:poem][:languages_attributes]
				params[:poem][:languages_attributes].each do |key, language|
					if !language.has_key?("id")
						new_language = Language.where(name: language[:name]).first_or_create
						@poem.languages << new_language
					end
				end
			end

			if @existing_groups
				@poem.groups = Group.where(id: @existing_groups)
			end
			if params[:poem][:groups_attributes]
				params[:poem][:groups_attributes].each do |key, group|
					if !group.has_key?("id")
						new_group = Group.where(name: group[:name]).first_or_create
						@poem.groups << new_group
					end
				end 
			end

		end #super
	end #update

end # controller

end
