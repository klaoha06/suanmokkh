Deface::Override.new(:virtual_path => "spree/shared/_header",
:name => 'logo',
:replace => "erb[loud]:contains('logo')",
:text => '<a id="mylogo" href="/store"><i class="fa fa-play-circle-o fa-rotate-90 fa-lg"></i> <span id="store_title">SUAN MOKKH BOOK STORE</span></a>')

Deface::Override.new(:virtual_path => "spree/shared/_header",
:name => 'change_column',
:set_attributes => 'figure#logo',
:attributes => {:class => 'col-md-5'}
)