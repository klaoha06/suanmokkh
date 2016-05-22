class SuanmokkhController < ApplicationController
	def suanmokkh
		get_page = Page.where(identifier: 'Suanmokkh').first
		if get_page
			@page = get_page
		else
			@page = Page.find(2)
		end
	end
end
