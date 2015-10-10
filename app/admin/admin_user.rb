ActiveAdmin.register AdminUser do
  config.per_page = 15

  permit_params :email, :username, :password, :password_confirmation

  show do
    panel "Book(s) created by this admin user..." do
      table_for(admin_user.books) do
        column("Book ID", :sortable => :id) {|book| link_to "##{book.id}", admin_book_path(book) }
        column("Title") {|book| book.title}
        column :draft, :sortable => :draft do |book|
          status_tag((book.draft? ? "Not Published" : "Published"), (book.draft? ? :warning : :ok))
        end
        column("Created At", :sortable => :created_at){|book| pretty_format(book.created_at) }
      end
      div :style => 'display:inline; text-align:center; padding: 5px;' do
        para :style => 'display:inline-block; margin:0;' do
          ("Number of Books in Archieve - <strong>#{admin_user.books.count}</strong>").html_safe
        end
        a ' See all', :href => admin_books_path(), :style => 'float:right'
      end
    end
    panel "Retreat Talk(s) created by this admin user..." do
      table_for(admin_user.retreat_talks) do
        column("Retreat Talk ID", :sortable => :id) {|retreat_talk| link_to "##{retreat_talk.id}", admin_article_path(article) }
        column("Title") {|retreat_talk| retreat_talk.title}
        column :draft, :sortable => :draft do |retreat_talk|
          status_tag((retreat_talk.draft? ? "Not Published" : "Published"), (retreat_talk.draft? ? :warning : :ok))
        end
        column("Created At", :sortable => :created_at){|retreat_talk| pretty_format(retreat_talk.created_at) }
      end
      div :style => 'display:inline; text-align:center; padding: 5px;' do
        para :style => 'display:inline-block; margin:0;' do
          ("Number of Books in Archieve - <strong>#{admin_user.retreat_talks.count}</strong>").html_safe
        end
        a ' See all', :href => admin_articles_path(), :style => 'float:right'
      end
    end
    panel "Audio(s) created by this admin user..." do
      table_for(admin_user.audios) do
        column("Audio ID", :sortable => :id) {|audio| link_to "##{audio.id}", admin_audio_path(audio) }
        column("Title") {|audio| audio.title}
        column :draft, :sortable => :draft do |audio|
          status_tag((audio.draft? ? "Not Published" : "Published"), (audio.draft? ? :warning : :ok))
        end
        column("Created At", :sortable => :created_at){|audio| pretty_format(audio.created_at) }
      end
      div :style => 'display:inline; text-align:center; padding: 5px;' do
        para :style => 'display:inline-block; margin:0;' do
          ("Number of Books in Archieve - <strong>#{admin_user.audios.count}</strong>").html_safe
        end
        a ' See all', :href => admin_audios_path(), :style => 'float:right'
      end
    end
    # panel "News Article(s) created by this admin user..." do
    #   table_for(admin_user.news_articles) do
    #     column("News Article ID", :sortable => :id) {|article| link_to "##{article.id}", admin_news_article_path(article) }
    #     column("Title") {|article| article.title}
    #     column :draft, :sortable => :draft do |article|
    #       status_tag((article.draft? ? "Not Published" : "Published"), (article.draft? ? :warning : :ok))
    #     end
    #     column("Created At", :sortable => :created_at){|article| pretty_format(article.created_at) }
    #   end
    #   div :style => 'display:inline; text-align:center; padding: 5px;' do
    #     para :style => 'display:inline-block; margin:0;' do
    #       ("Number of Books in Archieve - <strong>#{admin_user.news_articles.count}</strong>").html_safe
    #     end
    #     a ' See all', :href => admin_news_articles_path(), :style => 'float:right'
    #   end
    # end
    panel "Poem(s) created by this admin user..." do
      table_for(admin_user.poems) do
        column("Poem ID", :sortable => :id) {|poem| link_to "##{poem.id}", admin_poem_path(poem) }
        column("Title") {|poem| poem.title}
        column :draft, :sortable => :draft do |poem|
          status_tag((poem.draft? ? "Not Published" : "Published"), (poem.draft? ? :warning : :ok))
        end
        column("Created At", :sortable => :created_at){|poem| pretty_format(poem.created_at) }
      end
      div :style => 'display:inline; text-align:center; padding: 5px;' do
        para :style => 'display:inline-block; margin:0;' do
          ("Number of Books in Archieve - <strong>#{admin_user.poems.count}</strong>").html_safe
        end
        a ' See all', :href => admin_poems_path(), :style => 'float:right'
      end
    end

  end

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :username
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :username
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
