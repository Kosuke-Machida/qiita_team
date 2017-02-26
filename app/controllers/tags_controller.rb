class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag
              .order("updated_at DESC")
              .page(params[:page])
              .per(10)
  end
end
