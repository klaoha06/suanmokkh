ActiveAdmin.register Subscriber, as: "Subscriber" do
	permit_params :firstname, :id, :lastname, :username, :email

	# index as: :blog do
	#   title do |feedback|
	#   	hr
	#   	h3 style: 'text-align: center;' do
	#   		feedback.title
	#   	end
	#   end
	#   body do |feedback|
	#   	h4 style: 'text-align: center;' do
	#   		feedback.content
	#   	end
	#   	h5 style: 'text-align: center;' do
	#   		'demand response? ' + feedback.reply.to_s
	#   	end
	#   end 
	# end

end