class AddEbookTypetoBook < ActiveRecord::Migration
  def change
  	add_column :books, :ebook, :boolean, default: true
  	add_column :books, :normalbook, :boolean, default: true
  end
end
