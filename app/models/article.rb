class Article < ActiveRecord::Base
	has_attached_file :photo

		def create
			@article = Article.new(article_params)
		end

		private

	  def article_params
	    params.require(:article).permit(:title, :cover_img, :publisher, :content, :group, :language, :reads, :series, :photo, :allow_comments)
	  end
end
