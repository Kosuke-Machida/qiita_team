class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag
              .order("taggings_count DESC")
              .page(params[:page])
              .per(10)
  end
end
