class CreateNewsArticles < ActiveRecord::Migration
  def change
    create_table :news_articles do |t|
  		t.string :title
  		t.text :content
  	  t.string :language

  	  t.string :author

  	  t.integer :views

  	  t.boolean :draft, default: false
  	  t.boolean :featured, default: false
  	  t.boolean :allow_comments, default: true

      t.timestamps null: false
    end
  end
end
