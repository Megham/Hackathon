class CommentsController < ApplicationController
  def create
    @idea = Idea.find(params[:idea_id])
    @idea.comments.create(params[:comment])
    redirect_to @idea
  end
end
