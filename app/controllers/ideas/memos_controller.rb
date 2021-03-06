class Ideas::MemosController < ApplicationController
  before_action :set_memo
  before_action :is_matched_user?, only: [:update, :destroy, :move]

  
  def create
    @memo = Memo.new(memo_params)
    respond_to do |format|
      if @memo.save
        format.html { redirect_to company_ideas_path(@company_id) }
        format.json { render :show, status: :created }
      else
        redirect_to company_ideas_path(@company_id)
      end
    end
  end

  def update
    respond_to do |format|
      if @memo.update(memo_params)
        format.html { redirect_to company_ideas_path(@company_id) }
        format.json { render :show, status: :ok }
      else
        redirect_to company_ideas_path(@company_id)
      end
    end
  end

  def destroy
      @memo.destroy
      respond_to do |format|
        format.html { redirect_to company_ideas_path(@company_id) }
        format.json { head :no_content }
      end
  end

  def move
      @memo.update(memo_params)
      render action: :show
  end



  private
  def set_memo
    @memo = Memo.find(params[:id]) if params[:id]
    if params[:id]
      @company_id = Idea.find(Memo.find(params[:id]).idea_id).company_id
    else
      @company_id = Idea.find(params[:idea_id]).company_id
    end
    
  end

  def memo_params
    params.require(:memo).permit(:content, :position)
    .merge(
      user_id: current_user.id, 
      idea_id: params[:idea_id]
    )
  end

  def is_matched_user?
    unless current_user.id == @memo.user_id
      redirect_to company_ideas_path(@company_id)
    end
  end

end