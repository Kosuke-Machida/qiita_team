class SearchedArticlesController < ApplicationController
  def search
    viewable_articles = Article.available_to(current_user)
    @articles = if params[:keyword] == ""
                  viewable_articles
                elsif params[:keyword]
                  Article.body_include(params[:keyword])
                end
    @keyword = params[:keyword]
    respond_to do |format|
      format.js
    end
  end
end
