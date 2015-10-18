class Collection < ActiveRecord::Base
	belongs_to :book
	belongs_to :related_book, :class_name => "Book"
end
