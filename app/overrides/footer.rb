Deface::Override.new(:virtual_path  => "spree/layouts/spree_application",
                     :insert_after => "body",
                     :partial => 'spree/footer',
                     :name          => "footer",
                     )