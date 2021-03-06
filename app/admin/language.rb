ActiveAdmin.register Language do
	permit_params :name, :id
  config.per_page = 15
	config.batch_actions = true

	belongs_to :book, optional: true
	belongs_to :article, optional: true
	belongs_to :audio, optional: true
  belongs_to :group, optional: true
	belongs_to :poem, optional: true
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
index do
  selectable_column
  id_column
  column :name
  column :number_of_groups do |language|
    a language.groups.count, :href => admin_groups_path()
  end
  column :number_of_audios do |language|
    a language.audios.count, :href => admin_audios_path()
  end
  column :number_of_retreat_talks do |language|
    a language.retreat_talks.count, :href => admin_retreat_talks_path()
  end
  # column :number_of_articles do |language|
  #     a language.articles.count, :href => admin_articles_path()
  # end
  # column :number_of_news_articles do |language|
  #   a language.news_articles.count, :href => admin_news_articles_path()
  # end
  column :number_of_poems do |language|
    a language.poems.count, :href => admin_poems_path()
  end
  column :created_at
  actions
end

show :title => :name do
  panel "Book(s) in this language..." do
    table_for(language.books.order('id desc')) do
      column("Book ID", :sortable => :id) {|book| link_to "##{book.id}", admin_book_path(book) }
      column("Title") {|book| link_to "#{book.title}", admin_book_path(book)}
      column("Status") {|book| status_tag(book.draft? ? "Not Published" : "Published")}
      column("Created At", :sortable => :created_at){|book| pretty_format(book.created_at) }
      column("Actions") {|book| a ' Go to', :href => admin_book_path(book), :class => "button"}
    end
    div :style => 'display:inline; text-align:center; padding: 5px;' do
      para :style => 'display:inline-block; margin:0;' do
        ("Number of Books In This Language - <strong>#{language.books.count}</strong>").html_safe
      end
      a ' See all', :href => admin_books_path(), :style => 'float:right'
    end
  end
  panel "Article(s) In This Language..." do
    table_for(language.articles.order('id desc')) do
      column("Article ID", :sortable => :id) {|article| link_to "##{article.id}", admin_article_path(article) }
      column("Title") {|article| link_to "##{article.id}", admin_article_path(audio)}
      column("Created At", :sortable => :created_at){|article| pretty_format(article.created_at) }
      column("Status") {|article| status_tag(article.draft? ? "Not Published" : "Published")}
      column("Actions") {|article| a ' Go to', :href => admin_article_path(article), :class => "button"}
    end
    div :style => 'display:inline; text-align:center; padding: 5px;' do
      para :style => 'display:inline-block; margin:0;' do
        ("Number of Audios In This Language - <strong>#{language.articles.count}</strong>").html_safe
      end
       a ' See all', :href => admin_articles_path(), :style => 'float:right'
    end
  end
  panel "Audio(s) In This Language..." do
    table_for(language.audios.order('id desc')) do
      column("Audio ID", :sortable => :id) {|audio| link_to "##{audio.id}", admin_audio_path(audio) }
      column("Title") {|audio| link_to "#{audio.title}", admin_audio_path(audio)}
      column("Created At", :sortable => :created_at){|audio| pretty_format(audio.created_at) }
      column("Actions") {|audio| a ' Go to', :href => admin_audio_path(audio), :class => "button"}
    end
    div :style => 'display:inline; text-align:center; padding: 5px;' do
      para :style => 'display:inline-block; margin:0;' do
        ("Number of Audios In This Language - <strong>#{language.audios.count}</strong>").html_safe
      end
       a ' See all', :href => admin_audios_path(), :style => 'float:right'
    end
  end
  panel "Poem(s) In This Language..." do
    table_for(language.poems.order('id desc')) do
      column("Poem ID", :sortable => :id) {|poem| link_to "##{poem.id}", admin_poem_path(poem) }
      column("Title") {|poem| link_to "##{poem.title}", admin_poem_path(poem)}
      column("Created At", :sortable => :created_at){|poem| pretty_format(poem.created_at) }
      column("Status") {|poem| status_tag(poem.draft? ? "Not Published" : "Published")}
      column("Actions") {|poem| a ' Go to', :href => admin_poem_path(poem), :class => "button"}
    end
    div :style => 'display:inline; text-align:center; padding: 5px;' do
      para :style => 'display:inline-block; margin:0;' do
        ("Number of Poems In This Language - <strong>#{language.poems.count}</strong>").html_safe
      end
       a ' See all', :href => admin_poems_path(), :style => 'float:right'
    end
  end
end

end
