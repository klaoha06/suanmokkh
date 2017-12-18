class AddJoinTableForEbook < ActiveRecord::Migration
  def change
  	create_table :authors_ebooks, id: false do |t|
  	  t.belongs_to :author, index: true
  	  t.belongs_to :ebook, index: true
  	end
  	create_table :ebooks_publishers, id: false do |t|
  	  t.belongs_to :publisher, index: true
  	  t.belongs_to :ebook, index: true
  	end
  	create_table :audios_ebooks, id: false do |t|
  	  t.belongs_to :audio, index: true
  	  t.belongs_to :ebook, index: true
  	end
  	create_table :ebooks_groups, id: false do |t|
  	  t.belongs_to :ebook, index: true
  	  t.belongs_to :group, index: true
  	end
  	create_table :ebooks_languages, id: false do |t|
  	  t.belongs_to :ebook, index: true
  	  t.belongs_to :language, index: true
  	end
    create_table :ebooks_retreat_talks, id: false do |t|
      t.belongs_to :ebook, index: true
      t.belongs_to :retreat_talk, index: true
    end
  end
end
