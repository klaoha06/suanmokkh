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
        panel "Recent Articles" do
          table_for Article.order('id desc').limit(10) do
              column("Title") {|article| article.title}
              column("Created At") {|article| article.created_at}
              column("Status") {|article| status_tag(article.draft? ? "Not Yet Published" : "Published")}
          end
            para "Number of Articles in Archieve - #{Article.count}"
        end
      end
    end

    columns do
      # column do
      #   panel "Recent Books" do
      #     ul do
      #       Book.recent(5).map do |book|
      #         li link_to(book.title, admin_book_path(book))
      #       end
      #     end
      #   end
      # end
      column do
        panel "Recent Books" do
          table_for Book.order('id desc').limit(10) do
              column("Title") {|book| book.title}
              column("Created At") {|book| book.created_at}
              column("Status") {|book| status_tag(book.draft? ? "Not Yet Published" : "Published")}
              column("Downloads") {|book| book.downloads}
              # attachment_column :file, truncate: false
            # column("State")   {|order| status_tag(order.state)                                    }
            # column("File"){|book| link_to(order.user.email, admin_customer_path(order.user)) }
            # column("Total")   {|order| number_to_currency order.total_price                       }
          end
            para "Number of Books in Archieve - #{Book.count}"
        end

      end





      # column do
      #   panel "Info" do
      #     para "Welcome to ActiveAdmin."
      #   end
      # end

    end

    columns do
        column do
          panel "Recent Audio" do
            table_for Audio.order('id desc').limit(10) do
                column("Title") {|audio| audio.title}
                column("Created At") {|audio| audio.created_at}
                column("Status") {|audio| status_tag(audio.draft? ? "Not Yet Published" : "Published")}
                column("Downloads") {|audio| audio.downloads}        
            end
              para "Number of Audios in Archieve - #{Audio.count}"
          end
        end
        column do
          panel "Recent Video" do
            table_for Video.order('id desc').limit(10) do
                column("Title") {|video| video.title}
                column("Created At") {|video| video.created_at}
                column("Status") {|video| status_tag(video.draft? ? "Not Yet Published" : "Published")}
                column("Downloads") {|video| video.downloads}        
            end
              para "Number of Videos in Archieve - #{Video.count}"
          end
        end

    end

  end # content
end
