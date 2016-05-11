Deface::Override.new(:virtual_path => "spree/shared/_products", 
                     :name => "example-5", 
                     :surround => "erb[loud]:contains('paginate')",
                     :text => "<nav class='text-center'><%= render_original %></nav>")

Deface::Override.new(:virtual_path  => "spree/shared/_products",
                     :insert_after => "br",
                     :text => '<br/>',
                     :name          => "br",
                     )
Deface::Override.new(:virtual_path  => "spree/shared/_products",
                     :insert_after => "br",
                     :text => '<br/>',
                     :name          => "br",
                     )