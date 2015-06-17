class CreateNewsArticles < ActiveRecord::Migration
  def change
    create_table :news_articles do |t|
  		t.string :title
  		t.text :content

  	  t.string :author

  	  t.boolean :draft, default: false
  	  t.boolean :featured, default: false
  	  t.boolean :allow_comments, default: true

      t.belongs_to :admin_user, index:true

      t.integer :views, default: 0
      t.integer :shares, default: 0

      t.timestamps null: false
    end
  end
end
