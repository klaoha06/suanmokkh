ActiveAdmin.register Page do
	config.per_page = 15
	permit_params :id, :content, :draft, :title, :identifier

index do
	selectable_column
	id_column
	column :title
	column :identifier
	column :draft, :sortable => :draft do |page|
		status_tag((page.draft? ? "Not Published" : "Published"), (page.draft? ? :warning : :ok))
	end
	column :created_at
	actions
end

show do |page|
  panel "Page Details" do
  	attributes_table_for page do
  			row :identifier
  	    row :title
  	    row :id
  	    row :created_at
  	    row :updated_at
  	    row "Content" do
	  	    	text_node page.content.html_safe
  	    end
  	  end
  end
 end

form :html => { :enctype => "multipart/form-data" } do |f|
	tabs do
	      tab 'Basic' do
	        f.inputs 'Basic Info' do
	        	f.input :title, :required => true
	        	f.input :content, :as => :ckeditor, :input_html => { :ckeditor => { :height => 400 } }
	        end
	        f.inputs 'Publish Status' do
	        	f.input :identifier
	        	f.input :draft, :label => "Make this a draft?"
	        end
	      end
	    end
	f.actions
end

end
