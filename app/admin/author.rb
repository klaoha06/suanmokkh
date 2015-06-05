ActiveAdmin.register Author do
	permit_params :name, :first_name, :last_name, :brief_biography
	# menu :priority => 4
  config.batch_actions = true

  belongs_to :book, optional: true
  # navigation_menu :book

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

show :title => :name do
  panel "Book(s) written by this author..." do
    table_for(author.books) do
      column("Book ID", :sortable => :id) {|book| link_to "##{book.id}", admin_book_path(book) }
      column("Title") {|book| book.title}
      column("Draft")                   {|book| status_tag(book.draft) }
      column("Created At", :sortable => :created_at){|book| pretty_format(book.created_at) }
    end
  end
end

sidebar "Author Details", :only => :show do
  attributes_table_for author, :name, :first_name, :last_name, :brief_biography
end

# sidebar "Order History", :only => :show do
#   attributes_table_for customer do
#     row("Total Orders") { customer.orders.complete.count }
#     row("Total Value") { number_to_currency customer.orders.complete.sum(:total_price) }
#   end
# end

end
