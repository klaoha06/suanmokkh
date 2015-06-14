ActiveAdmin.register Language do
	permit_params :name, :id
	config.batch_actions = true

	belongs_to :book, optional: true
	belongs_to :article, optional: true
	belongs_to :audio, optional: true
	belongs_to :group, optional: true
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

show :title => :name do
  panel "Book(s) in this language..." do
    table_for(language.books) do
      column("Book ID", :sortable => :id) {|book| link_to "##{book.id}", admin_book_path(book) }
      column("Title") {|book| book.title}
      column("Draft")                   {|book| status_tag(book.draft) }
      column("Created At", :sortable => :created_at){|book| pretty_format(book.created_at) }
    end
  end
  panel "Article(s) in this language..." do
    table_for(language.articles) do
      column("Article ID", :sortable => :id) {|article| link_to "##{article.id}", admin_article_path(article) }
      column("Title") {|article| article.title}
      column("Draft")                   {|article| status_tag(article.draft) }
      column("Created At", :sortable => :created_at){|article| pretty_format(article.created_at) }
    end
  end
  panel "Audio(s) in this language..." do
    table_for(language.audios) do
      column("Audio ID", :sortable => :id) {|audio| link_to "##{audio.id}", admin_audio_path(audio) }
      column("Title") {|audio| audio.title}
      column("Draft")                   {|audio| status_tag(audio.draft) }
      column("Created At", :sortable => :created_at){|audio| pretty_format(audio.created_at) }
    end
  end
end


end
