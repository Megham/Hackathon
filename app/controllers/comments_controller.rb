class CommentsController < ApplicationController
  def create
    @idea = Idea.find(params[:idea_id])
    p "comment creating...."
    @idea.comments.create(params[:comment])
    p "comment created"
    redirect_to @idea
  end
end
