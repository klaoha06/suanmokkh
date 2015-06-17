ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #

    columns do
      column do
        panel "Recent Books" do
          table_for Book.order('id desc').limit(10) do
              column "cover_img", :sortable => false do |book|
                "<img src='#{book.cover_img.url}' alt='book cover_img' style='width:70px; max-height: none;height:100x; display:block; margin:0 auto;'/>".html_safe
              end
              column("Title") {|book| book.title}
              column("Created At") {|book|pretty_format( book.created_at)}
              column("Status") {|book| status_tag(book.draft? ? "Not Yet Published" : "Published")}
              column("Actions") {|book| a ' Go to', :href => admin_book_path(book), :class => "button"}
              # column("Downloads") {|book| book.downloads}
              # attachment_column :file, truncate: false
            # column("State")   {|order| status_tag(order.state)                                    }
            # column("File"){|book| link_to(order.user.email, admin_customer_path(order.user)) }
            # column("Total")   {|order| number_to_currency order.total_price                       }
          end
          div :style => 'display:inline; text-align:center; padding: 5px;' do
            para :style => 'display:inline-block; margin:0;' do
              ("Number of Books in Archieve - <strong>#{Book.count}</strong>").html_safe
            end
            a ' See all', :href => admin_books_path(), :style => 'float:right'
          end
        end
      end
      column do
        panel "Recent Articles" do
          table_for Article.order('id desc').limit(10) do
              column "cover_img", :sortable => false do |article|
                "<img src='#{article.cover_img.url}' alt='article cover_img' style='width:70px; max-height: none;height:100x; display:block; margin:0 auto;'/>".html_safe
              end
              column("Title") {|article| article.title}
              column("Created At") {|article| pretty_format(article.created_at)}
              column("Status") {|article| status_tag(article.draft? ? "Not Yet Published" : "Published")}
              column("Actions") {|article| a ' Go to', :href => admin_article_path(article), :class => "button"}
          end
          div :style => 'display:inline; text-align:center; padding: 5px;' do
            para :style => 'display:inline-block; margin:0;' do
             ("Number of Articles in Archieve - <strong>#{Article.count}</strong>").html_safe
            end
             a ' See all', :href => admin_articles_path(), :style => 'float:right'
          end
        end
      end
    end

    columns do
        column do
          panel "Recent Audio" do
            table_for Audio.order('id desc').limit(10) do
                column("Title") {|audio| audio.title}
                column("Created At") {|audio| pretty_format(audio.created_at)}
                column("Status") {|audio| status_tag(audio.draft? ? "Not Yet Published" : "Published")}
                # column("Downloads") {|audio| audio.downloads}
                column("Actions") {|audio| a ' Go to', :href => admin_audio_path(audio), :class => "button"}
      
            end
            div :style => 'display:inline; text-align:center; padding: 5px;' do
              para :style => 'display:inline-block; margin:0;' do
                ("Number of Audios in Archieve - <strong>#{Audio.count}</strong>").html_safe
              end
               a ' See all', :href => admin_audios_path(), :style => 'float:right'
            end

          end
        end
        column do
          panel "Recent Video" do
            table_for Video.order('id desc').limit(10) do
                column("Title") {|video| video.title}
                column("Created At") {|video| pretty_format(video.created_at)}
                column("Status") {|video| status_tag(video.draft? ? "Not Yet Published" : "Published")}
                # column("Downloads") {|video| video.downloads}    
                column("Actions") {|video| a ' Go to', :href => admin_video_path(video), :class => "button"}
    
            end
            div :style => 'display:inline; text-align:center; padding: 5px;' do
              para :style => 'display:inline-block; margin:0;' do
                ("Number of Videos in Archieve - <strong>#{Video.count}</strong>").html_safe
              end
              a ' See all', :href => admin_videos_path(), :style => 'float:right'
            end
          end
        end
      end

      columns do
        column do
          panel "Recent Poems" do
            table_for Poem.order('id desc').limit(10) do
                # column "cover_img", :sortable => false do |poem|
                #   "<img src='#{poem.cover_img.url}' alt='poem cover_img' style='width:70px; max-height: none;height:100x; display:block; margin:0 auto;'/>".html_safe
                # end
                column("Title") {|poem| poem.title}
                column("Created At") {|poem| pretty_format(poem.created_at)}
                column("Status") {|poem| status_tag(poem.draft? ? "Not Yet Published" : "Published")}
                column("Actions") {|poem| a ' Go to', :href => admin_poem_path(poem), :class => "button"}
            end
            div :style => 'display:inline; text-align:center; padding: 5px;' do
              para :style => 'display:inline-block; margin:0;' do
               ("Number of poems in Archieve - <strong>#{Poem.count}</strong>").html_safe
              end
               a ' See all', :href => admin_poems_path(), :style => 'float:right'
            end
          end
        end
      end

  end # content
end
