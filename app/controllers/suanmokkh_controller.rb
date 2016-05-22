class SuanmokkhController < ApplicationController
	def suanmokkh
		get_page = Page.where(identifier: 'Suanmokkh').first
		if get_page
			@page = get_page
		else
			if Page.where(id: 2).first
				@page = Page.where(id: 2).first
			else
				@page = nil
			end
		end
	end
end
