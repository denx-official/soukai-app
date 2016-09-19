class ProjectsController < ApplicationController
  include Common
  layout :select_layout
  before_action :set_new_project_id, only: [:new, :create]
  before_action :set_project_id, only: [:edit, :update]
  before_action :set_soukais, only: [:new, :create, :edit]
  before_action :project_create_user?, only: [:edit, :update, :destroy]
  
  def index
    @projects = Project.paginate(page: params[:page])
    soukais = Soukai.find(@projects.map(&:soukai_id))
    @soukai_name = {}
    soukais.each do |soukai|
      @soukai_name[soukai.id] = soukai.name
    end
  end
  
  def show
    @project = Project.find(params[:id])
    @planner = User.find(@project.user_id.to_i)
    @project_options = ProjectOption.where(project_id: params[:id])
    @votes = Vote.where(project_id: params[:id])
    
    @vote_counts = {}
    @project_options.each_with_index do |project_option, i|
      @vote_counts[i] = @votes.where(project_option_id: project_option.id).size
    end
    @disapproved_count = @votes.where(project_option_id: nil).try(:size) || 0
    # binding pry
  end
  
  def new
    @project = Project.new
    @project.project_option.build
  end
  
  def create
    @project_id = Project.last.id.to_i + 1
    @project = Project.new(project_params)
    if @project.save 
      flash[:info] = "プロジェクトが登録されました"
      redirect_to @project
    else
      render 'new'
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "変更されました"
      redirect_to @project
    else
      render 'edit'
    end
  end
  
  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "プロジェクトを削除しました"
    redirect_to projects_url
  end
  
  private
    def project_params
      params.require(:project).permit(
        :name, :soukai_id, :user_id, :password, :password_confirmation,
        project_option_attributes: [:id, :name, :price, :project_id, :remarks, :_destroy]
        )
    end
    
    def set_new_project_id
      @project_id = Project.last.present? ? Project.last.id.to_i + 1 : 0
    end
    
    def set_project_id
      @project_id = Project.find(params[:id]).id.to_i
    end
    
    def set_soukais
      @soukais = Soukai.narrow_year(Date.today.year)
    end
    
    def project_create_user?
      redirect_to(root_url) unless current_user.admin? || Project.find(params[:id])[:user_id] == current_user
    end
end
