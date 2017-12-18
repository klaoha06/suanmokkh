class EbookCollection < ActiveRecord::Base
	belongs_to :ebook
	belongs_to :related_ebook, :class_name => "Ebook"
end
