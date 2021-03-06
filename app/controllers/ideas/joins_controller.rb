class Ideas::JoinsController < ApplicationController
  before_action :set_idea_id

  def index
    render json: IdeaMember.filter_by_idea(@idea_id).select(:id, :user_id, :idea_id)
  end
  def create
    @company = Idea.find(@idea_id).company
    if current_user.idea_members.find_by(idea_id: @idea_id)
      redirect_to public_company_ideas_path(@company)
    else
      current_user.idea_members.create!(join_params)
      head :created
    end
  end

  def destroy
    current_user.idea_members.find(params[:id]).destroy!
    head :ok
  end

  private

  def set_idea_id
    @idea_id = params[:idea_id]
  end
  def join_params
    params.require(:join).permit(:idea_id)
  end
end
