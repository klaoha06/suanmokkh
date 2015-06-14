ActiveAdmin.register Publisher do
	# menu priority: 4
	permit_params :name, :title
	config.batch_actions = true

	belongs_to :book, optional: true
	belongs_to :article, optional: true

	show :title => :name do
	  panel "Book(s) from this publisher..." do
	    table_for(publisher.books) do
	      column("Book ID", :sortable => :id) {|book| link_to "##{book.id}", admin_book_path(book) }
	      column("Title") {|book| book.title}
	      column("Draft")                   {|book| status_tag(book.draft) }
	      column("Created At", :sortable => :created_at){|book| pretty_format(book.created_at) }
	    end
	  end
	  panel "Article(s) from this publisher..." do
	    table_for(publisher.articles) do
	      column("Article ID", :sortable => :id) {|book| link_to "##{article.id}", admin_article_path(article) }
	      column("Title") {|article| article.title}
	      column("Draft")                   {|article| status_tag(article.draft) }
	      column("Created At", :sortable => :created_at){|article| pretty_format(article.created_at) }
	    end
	  end
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
# form do |f|
#   f.inputs "Details" do
#     f.name
#   end

#   # f.has_many :articles do |photo|
#   #   photo.inputs "Articles" do
#   #     photo.input :field_name 
#   #     #repeat as necessary for all fields
#   #   end
#   # end
#   # f.has_many :books do |photo|
#   #   photo.inputs "Books" do
#   #     photo.input :field_name 
#   #     #repeat as necessary for all fields
#   #   end
#   # end

# end

end
