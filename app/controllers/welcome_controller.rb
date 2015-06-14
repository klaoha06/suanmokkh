class WelcomeController < ApplicationController
  	@query = nil
  def index
  	@books = Book.where(@query).order('created_at DESC').limit(10)
  	@articles = Article.order('created_at DESC').limit(10)
  	@featured_article = Article.order('created_at DESC').find_by(featured: true)
  	@featured_book = Book.order('created_at DESC').find_by(featured: true)
  	if !@featured_book
  		@featured_book = @books.first
  	end
  	@news_articles = NewsArticle.order('created_at DESC').limit(6)
  	@featured_news_article = NewsArticle.order('created_at DESC').find_by(featured: true)
  	if !@featured_news_article
  		@featured_news_article = @news_articles.first
  	end
  	# @news_articles = NewsArticle.order('created_at DESC').limit(5)
  end

end
