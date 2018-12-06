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
    # render 'google_analytics'

    columns do
      column do
        panel "Books" do
          table_for Book.order('id desc').limit(10) do
            column "cover_img", :sortable => false do |book|
              if book.cover_img_file_name
                "<img src='#{book.cover_img.url}' alt='book cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe
              else
                "<img src='#{book.external_cover_img_link}' alt='book cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe
               end
            end
            column("Title") {|book| book.title}
            column("Created At") {|book|pretty_format( book.created_at)}
            column("Status") {|book| status_tag(book.draft? ? "Not Published" : "Published")}
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
        panel "Retreat Talks" do
          table_for RetreatTalk.order('id desc').limit(10) do
            column "cover_img", :sortable => false do |retreat_talk|
              if retreat_talk.cover_img_file_name
                "<img src='#{retreat_talk.cover_img.url}' alt='retreat_talk cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe
              else
                "<img src='#{retreat_talk.external_cover_img_link}' alt='retreat_talk cover_img' style='width:75px; max-height: none;height:150x; display:block; margin:0 auto;'/>".html_safe
               end
            end
            column("Title") {|retreat_talk| retreat_talk.title}
            column("Created At") {|retreat_talk| pretty_format(retreat_talk.created_at)}
            column("Status") {|retreat_talk| status_tag(retreat_talk.draft? ? "Not Published" : "Published")}
            column("Actions") {|retreat_talk| a ' Go to', :href => admin_retreat_talk_path(retreat_talk), :class => "button"}
          end
          div :style => 'display:inline; text-align:center; padding: 5px;' do
            para :style => 'display:inline-block; margin:0;' do
             ("Number of Retreat Talks in Archieve - <strong>#{RetreatTalk.count}</strong>").html_safe
            end
             a ' See all', :href => admin_retreat_talks_path(), :style => 'float:right'
          end
        end
      end
    end

    columns do
        column do
          panel "Audio" do
            table_for Audio.order('id desc').limit(10) do
                column("Title") {|audio| audio.title}
                column("Created At") {|audio| pretty_format(audio.created_at)}
                # column("Status") {|audio| status_tag(audio.draft? ? "Not Published" : "Published")}
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
          panel "Poems" do
            table_for Poem.order('id desc').limit(10) do
                # column "cover_img", :sortable => false do |poem|
                #   "<img src='#{poem.cover_img.url}' alt='poem cover_img' style='width:70px; max-height: none;height:100x; display:block; margin:0 auto;'/>".html_safe
                # end
                column("Title") {|poem| poem.title}
                column("Created At") {|poem| pretty_format(poem.created_at)}
                column("Status") {|poem| status_tag(poem.draft? ? "Not Published" : "Published")}
                column("Actions") {|poem| a ' Go to', :href => admin_poem_path(poem), :class => "button"}
            end
            div :style => 'display:inline; text-align:center; padding: 5px;' do
              para :style => 'display:inline-block; margin:0;' do
               ("Number of Poems in Archieve - <strong>#{Poem.count}</strong>").html_safe
              end
               a ' See all', :href => admin_poems_path(), :style => 'float:right'
            end
          end
        end

      end

      columns do
        column do
          panel "Feedbacks" do
            table_for Feedback.order('id desc').limit(10) do
                column("Title") {|feedback| feedback.title}
                column("Content") {|feedback| feedback.content}
                column("Created At") {|feedback| pretty_format(feedback.created_at)}
                # column("Required response?") {|feedback| status_tag(feedback.required_response? ? "Required a response" : "Do not required response", feedback.required_response? ? :warning : :ok)}
                # column("Responsed?") {|feedback| status_tag(feedback.responsed? ? "Responsed" : "Not responsed yet", feedback.responsed? ? :ok : :warning)}
                column("Actions") {|feedback| a ' Go to', :href => admin_feedback_path(feedback), :class => "button"}
            end
            div :style => 'display:inline; text-align:center; padding: 5px;' do
              para :style => 'display:inline-block; margin:0;' do
               ("Number of Feedbacks in Archieve - <strong>#{Feedback.count}</strong>").html_safe
              end
               a ' See all', :href => admin_feedbacks_path(), :style => 'float:right'
            end
          end
        end
      end

  end # content
end
