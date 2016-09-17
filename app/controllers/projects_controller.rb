class ProjectsController < ApplicationController
  include Common
  
  def index
    @projects = Project.paginate(page: params[:page])
  end
  
  def show
    @project = Project.find(params[:id])
    @project_options = ProjectOption.where(project_id: params[:id])
    project_votes = ProjectVote.where(project_id: params[:id])
    
    @project_vote_counts = {}
    @project_options.size.times.with_index do |i|
      @project_vote_counts[i] = project_votes.where(project_option_id: i+1).size
    end
  end
  
  def new
    @project = Project.new
    @project_option = ProjectOption.new
  end
  
  def create
    @project = Project.new(project_params)
    @project_option = ProjectOption.new(project_params)
    if @project.save
      flash[:info] = "プロジェクトが登録されました"
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
  end
  
  private
    def project_params
    end
end
