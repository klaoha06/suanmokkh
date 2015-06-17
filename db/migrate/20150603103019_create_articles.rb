class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
    	t.string :title
    	t.text :content_or_description
    	t.date :creation_date
        # t.string :language
        t.string :series
        # t.string :group
        
        # t.string :publisher
        t.date :publication_date

    	t.boolean :draft, default: false
    	t.boolean :featured, default: false
    	t.boolean :allow_comments, default: true

        t.integer :views, default: 0
    	t.integer :shares, default: 0

        t.belongs_to :admin_user, index:true

    	# t.belongs_to :publisher, index:true

      t.timestamps null: false
    end
  end
end
