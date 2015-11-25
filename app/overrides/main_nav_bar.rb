Deface::Override.new(:virtual_path => "spree/shared/_main_nav_bar",
:name => 'homelink',
:replace => "erb[loud]:contains('t(:home)')",
:text => '
		<li><a href="/store">Store</a></li>
		<li><a href="/">Back to Suan Mokkh</a></li>
')

		# <li class="dropdown">
		#           <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Navigation <span class="caret"></span></a>
		#           <ul class="dropdown-menu">
		#             <li><a href="/store">Store</a></li>
		#             <li><a href="/store/account">My Account</a></li>
		#             <li role="separator" class="divider"></li>
		#             <li><a href="/">Back to Suan Mokkh</a></li>
		#           </ul>
		#         </li>