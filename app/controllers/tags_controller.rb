class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.page(params[:page]).per(10)
  end
end
