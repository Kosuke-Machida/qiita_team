class SearchedArticlesController < ApplicationController
  def search
    viewable_articles = Article.available_to(current_user)
    @articles = viewable_articles.body_include(params[:keyword])
    @keyword = params[:keyword]
    respond_to do |format|
      format.js
    end
  end
end
