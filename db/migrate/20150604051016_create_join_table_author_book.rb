class CreateJoinTableAuthorBook < ActiveRecord::Migration
  def change
    # create_join_table :books, :authors
    create_table :authors_books, id: false do |t|
      t.belongs_to :author, index: true
      t.belongs_to :book, index: true
    end
    create_table :articles_authors, id: false do |t|
      t.belongs_to :author, index: true
      t.belongs_to :article, index: true
    end
    create_table :books_publishers, id: false do |t|
      t.belongs_to :publisher, index: true
      t.belongs_to :book, index: true
    end
    create_table :articles_publishers, id: false do |t|
      t.belongs_to :publisher, index: true
      t.belongs_to :article, index: true
    end
  end
end
