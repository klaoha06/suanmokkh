# Deface::Override.new(:virtual_path => "spree/products/_cart_form",
# :name => 'restyle_search',
# :replace => "erb[loud]:contains('add-to-cart-button')",
# :text => "<%= button_tag :class => 'btn btn-dark', :id => 'add-to-cart-button', :type => :submit do %>",
# :original => "<%= button_tag :class => 'btn btn-success', :id => 'add-to-cart-button', :type => :submit do %>")

Deface::Override.new(:virtual_path  => "spree/products/_cart_form",
                     :insert_after => "div .add-to-cart",
                     :text => '<br>',
                     :name          => "br",
                     )