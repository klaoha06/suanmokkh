Deface::Override.new(:virtual_path => "spree/shared/_filters",
:name => 'restyle_filters',
:replace => "erb[loud]:contains('submit_tag')",
:text => '<%= submit_tag Spree.t(:search), :name => nil, class: "btn btn-default" %><hr>
')

