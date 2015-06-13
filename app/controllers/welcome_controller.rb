class WelcomeController < ApplicationController
  	@query = nil
  def index
  	@books = Book.where(@query).order('created_at DESC').limit(10)
  	@articles = Article.order('created_at DESC').limit(10)
  	@featured_article = Article.order('created_at DESC').find_by(featured: true)
  	@featured_book = Book.order('created_at DESC').find_by(featured: true)
  	# @news_articles = NewsArticle.
  end

  def switch_section
  	@query = params[:format]
  	puts "YOYO " + @query
  end
end
