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
    table_for(language.books) do
      column("Book ID", :sortable => :id) {|book| link_to "##{book.id}", admin_book_path(book) }
      column("Title") {|book| link_to "##{book.id}", admin_book_path(book)}
      column("Status") {|book| status_tag(book.draft? ? "Not Published" : "Published")}
      column("Created At", :sortable => :created_at){|book| pretty_format(book.created_at) }
      column("Actions") {|book| a ' Go to', :href => admin_book_path(book), :class => "button"}
    end
  end
  # panel "Article(s) in this language..." do
  #   table_for(language.articles) do
  #     column("Article ID", :sortable => :id) {|article| link_to "##{article.id}", admin_article_path(article) }
  #     column("Title") {|article| link_to "##{article.id}", admin_article_path(audio)}
  #     column("Created At", :sortable => :created_at){|article| pretty_format(article.created_at) }
  #     column("Status") {|article| status_tag(article.draft? ? "Not Published" : "Published")}
  #     column("Actions") {|article| a ' Go to', :href => admin_article_path(article), :class => "button"}
  #   end
  # end
  panel "Audio(s) in this language..." do
    table_for(language.audios) do
      column("Audio ID", :sortable => :id) {|audio| link_to "##{audio.id}", admin_audio_path(audio) }
      column("Title") {|audio| link_to "##{audio.title}", admin_audio_path(audio)}
      column("Created At", :sortable => :created_at){|audio| pretty_format(audio.created_at) }
      column("Status") {|language| status_tag(language.draft? ? "Not Published" : "Published")}
      column("Actions") {|language| a ' Go to', :href => admin_language_path(language), :class => "button"}
    end
  end
  panel "Poem(s) in this language..." do
    table_for(language.poems) do
      column("Poem ID", :sortable => :id) {|poem| link_to "##{poem.id}", admin_poem_path(poem) }
      column("Title") {|poem| link_to "##{poem.title}", admin_poem_path(poem)}
      column("Created At", :sortable => :created_at){|poem| pretty_format(poem.created_at) }
      column("Status") {|poem| status_tag(poem.draft? ? "Not Published" : "Published")}
      column("Actions") {|poem| a ' Go to', :href => admin_poem_path(poem), :class => "button"}
    end
  end
end


end
