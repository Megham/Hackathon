class ParticipantsController < ApplicationController
  def create
    @idea = Idea.find(params[:idea_id])
    current_user = User.find_by_email(gmail_username)
    @idea.participants.create(:user => current_user, :idea => @idea) if @idea.can_accept_participant current_user
    redirect_to @idea
  end
end
