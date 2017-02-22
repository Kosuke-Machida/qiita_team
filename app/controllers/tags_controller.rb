class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.page(params[:page]).per(1)
  end
end
