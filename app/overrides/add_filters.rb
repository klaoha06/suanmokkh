# Deface::Override.new(:virtual_path  => "spree/home/index",
#                      :insert_after => "[data-hook='product_show']",
#                      :partial => 'spree/shared/filters',
#                      :text => "<%= render :partial => 'spree/shared/taxonomies', :locals => {:size => 30} %>",
#                      :name          => "filters",
#                      )