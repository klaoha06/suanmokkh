class HomeController < ApplicationController
  	helper ApplicationHelper
  def index
  	@books = Book.order('created_at DESC').limit(10).where(draft: false)
  	# @articles = Article.order('created_at DESC').limit(10)
  	# @featured_article = Article.order('created_at DESC').find_by(featured: true)
  	# @featured_book = Book.order('created_at DESC')
  	# if !@featured_book
  	# 	@featured_book = @books.first
  	# end

    # @featured_poems = Poem.where(featured: true).order('created_at DESC').limit(10)

    # sc_user = $sc_consumer.get('/me')
    # @number_of_audio_tracks = sc_user.track_count
    # @number_of_audio_tracks = soundcloud_user
  	# @news_articles = NewsArticle.order('created_at DESC').limit(6)
  	# @featured_news_article = NewsArticle.order('created_at DESC').find_by(featured: true)
  	# if !@featured_news_article
  	# 	@featured_news_article = @news_articles.first
  	# end
  	# @news_articles = NewsArticle.order('created_at DESC').limit(5)
  end

end
