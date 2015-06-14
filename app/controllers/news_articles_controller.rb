class NewsArticlesController < InheritedResources::Base

  private

    def news_article_params
      params.require(:news_article).permit()
    end
end

