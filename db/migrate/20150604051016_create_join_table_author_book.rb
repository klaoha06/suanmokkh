class CreateJoinTableAuthorBook < ActiveRecord::Migration
  def change
    # create_join_table :books, :authors
    create_table :authors_books, id: false do |t|
      t.belongs_to :author, index: true
      t.belongs_to :book, index: true
    end
  end
end
