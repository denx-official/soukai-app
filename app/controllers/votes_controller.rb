class VotesController < ApplicationController
  include Common
  layout        :select_layout
  before_action :logged_in_user, only: [:new, :create]
  
  def new
    soukai_id = Soukai.narrow_year(Date.today.year).map(&:id)
    @project_id = Project.where(soukai_id: soukai_id).order("id desc").map{|project| [project.name, project.id]}
    @project_options = ProjectOption.where(project_id: @project_id.map{|p| p[1]})
    @vote = Vote.new
  end
  
  def create
    @projects = Project.all
    @vote = Vote.new(project_id: params[:project_id], user_id: current_user.id, vote: params[:vote])
    
    if Vote.where(project_id: params[:project_id], user_id: current_user.id).blank?
      if @vote.save
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
  
  def project_options_select
  # ajax によるリクエストの場合のみ処理
    if request.xhr?
      if params[:vote_id].present? && params[:vote_id].to_s != 'votes'
        vote = vote.find(params[:vote_id])
      else
        vote = Vote.new
      end
  
      project_options = ProjectOption.select(:id, :name).where(project_id: params[:project_id])
  
      render partial: '/votes/form_project_options', locals: { vote: vote, project_options: project_options}
    end
  end
  
  private
      # ログイン済みユーザーかどうか確認
      def logged_in_user
        unless logged_in?
          vote_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end
end
