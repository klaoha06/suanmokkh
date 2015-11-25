Deface::Override.new(:virtual_path => "spree/shared/_main_nav_bar",
:name => 'homelink',
:replace => "erb[loud]:contains('t(:home)')",
:text => '      <li id="home-link" data-hook><a href="/">Suan Mokkh Main Page</a></li>
')