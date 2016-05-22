class BuddhadasaController < ApplicationController
	def buddhadasa
		get_page = Page.where(identifier: 'Buddhadasa').first
		if get_page
			@page = get_page
		else
			@page = Page.find(1)
		end
		# @description = 'Buddhadasa Bhikkhu (Servant of the Buddha) went forth as a bhikkhu (Buddhist monk) in 1926, at the age of twenty. After a few years of study in Bangkok, which convinced him "purity is not to be found in the big city" he was inspired to live close with nature in order to investigate the Buddha-Dhamma. Thus, he established Suan Mokkhabalarama (The Grove of the Power of Liberation) in 1932, near his hometown of Pum Riang (now in Chaiya District). At that time, it was the only forest Dhamma Center and one of the few places dedicated to vipassana meditation in Southern Thailand. Word of Buddhadasa Bhikkhu, his work, and Suan Mokkh spread over the years so that they are easily described as "one of the most influential events of Buddhist history in Siam" Here, we can only mention some of the most interesting services he has rendered Buddhism.'
	end
end
