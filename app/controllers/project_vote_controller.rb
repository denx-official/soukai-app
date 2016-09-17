class ProjectVoteController < ApplicationController
  include Common
  layout        :select_layout
  before_action :logged_in_user, only: [:new, :create]
  
  def new
    @projects = Project.all
    @project_vote = ProjectVote.new
  end
  
  def create
    @projects = Project.all
    @project_vote = ProjectVote.new(project_id: params[:project_id], user_id: current_user.id, vote: params[:vote])
    
    if ProjectVote.where(project_id: params[:project_id], user_id: current_user.id).blank?
      if @project_vote.save
        flash[:info] = "投票しました"
        redirect_to root_url
      else
        render 'new'
      end
    else
      flash.now[:info] = 'すでに投票は完了してます'
      render 'new'
    end
  end
  
  private
      # ログイン済みユーザーかどうか確認
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end
  
end
