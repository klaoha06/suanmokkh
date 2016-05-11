Deface::Override.new(:virtual_path => "spree/shared/_search",
:name => 'restyle_search',
:replace => "erb[loud]:contains('submit_tag')",
:text => '<%= submit_tag Spree.t(:search), :name => nil, class: "btn btn-default" %>
',
:original => '<%= submit_tag Spree.t(:search), :name => nil, class: "btn btn-success" %>
')