class ParticipantsController < ApplicationController
  def create
    raise_error_on_non_logged_in_user
    @idea = Idea.find(params[:idea_id])
    current_user = User.find_by_email(gmail_username)
    @idea.participants.create(:user => current_user, :idea => @idea) if @idea.can_accept_participant current_user
    redirect_to @idea
  end
  def destroy
    raise_error_on_non_logged_in_user
    @idea = Idea.find(params[:idea_id])
    @participant = @idea.participants.find(params[:id])
    raise_error_on_intrusion
    @participant.destroy
    redirect_to @idea
  end
  
  private
  
  def raise_error_on_intrusion
    raise t("hello") if gmail_username.nil? || @participant.user_id != User.find_by_email(gmail_username).id
  end

  def raise_error_on_non_logged_in_user
    raise t("hello") if gmail_username.nil?
  end

end
