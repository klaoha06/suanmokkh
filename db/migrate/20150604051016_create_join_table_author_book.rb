class CreateJoinTableAuthorBook < ActiveRecord::Migration
  def change
  	# Authors
    create_table :authors_books, id: false do |t|
      t.belongs_to :author, index: true
      t.belongs_to :book, index: true
    end
    create_table :articles_authors, id: false do |t|
      t.belongs_to :author, index: true
      t.belongs_to :article, index: true
    end
    create_table :authors_poems, id: false do |t|
      t.belongs_to :author, index: true
      t.belongs_to :poem, index: true
    end

    # Publishers
    create_table :books_publishers, id: false do |t|
      t.belongs_to :publisher, index: true
      t.belongs_to :book, index: true
    end
    create_table :articles_publishers, id: false do |t|
      t.belongs_to :publisher, index: true
      t.belongs_to :article, index: true
    end
    # Audio
    create_table :audios_books, id: false do |t|
      t.belongs_to :audio, index: true
      t.belongs_to :book, index: true
    end
    create_table :audios_authors, id: false do |t|
      t.belongs_to :audio, index: true
      t.belongs_to :author, index: true
    end

    # Group
    create_table :books_groups, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :group, index: true
    end
    create_table :articles_groups, id: false do |t|
      t.belongs_to :article, index: true
      t.belongs_to :group, index: true
    end
    create_table :audios_groups, id: false do |t|
      t.belongs_to :audio, index: true
      t.belongs_to :group, index: true
    end
    create_table :groups_poems, id: false do |t|
      t.belongs_to :poem, index: true
      t.belongs_to :group, index: true
    end


    # Languages
    create_table :groups_languages, id: false do |t|
      t.belongs_to :group, index: true
      t.belongs_to :language, index: true
    end
    create_table :audios_languages, id: false do |t|
      t.belongs_to :audio, index: true
      t.belongs_to :language, index: true
    end
    create_table :books_languages, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :language, index: true
    end
    create_table :articles_languages, id: false do |t|
      t.belongs_to :article, index: true
      t.belongs_to :language, index: true
    end
    create_table :languages_poems, id: false do |t|
      t.belongs_to :poem, index: true
      t.belongs_to :language, index: true
    end

    # News Articles
    create_table :groups_news_articles, id: false do |t|
      t.belongs_to :group, index: true
      t.belongs_to :news_article, index: true
    end
    create_table :languages_news_articles, id: false do |t|
      t.belongs_to :language, index: true
      t.belongs_to :news_article, index: true
    end


  end
end
