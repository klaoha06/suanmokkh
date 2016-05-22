class BuddhadasaController < ApplicationController
	def buddhadasa
		get_page = Page.where(identifier: 'Buddhadasa').first
		if get_page
			@page = get_page
		else
			if Page.where(id: 1).first
			@page = Page.where(id: 1).first
			else
				@page = nil
			end
		end
	end
end
