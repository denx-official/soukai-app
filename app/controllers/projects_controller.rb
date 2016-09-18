class ProjectsController < ApplicationController
  include Common
  
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
    @project_options = ProjectOption.where(project_id: params[:id])
    project_votes = ProjectVote.where(project_id: params[:id])
    
    @project_vote_counts = {}
    @project_options.size.times.with_index do |i|
      @project_vote_counts[i] = project_votes.where(project_option_id: i+1).size
    end
  end
  
  def new
    @soukais = Soukai.narrow_year(Date.today.year).order("date").reverse_order
    @last_project_id = Project.last.id.to_i
    @project = Project.new
    @project.project_option.build
  end
  
  def create
    @soukais = Soukai.narrow_year(Date.today.year)
    @project = Project.new(project_params)
    # binding pry
    if @project.save 
      flash[:info] = "プロジェクトが登録されました"
      redirect_to new_project_path
    else
      render 'new'
    end
  end
  
  
  
  
  
  
  
  def edit
    @project = Project.find(params[:id])
    @project.project_option.build
    @soukais = Soukai.narrow_year(Date.today.year).order("date").reverse_order
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
      params.require(:project).permit(
        :name, :soukai_id, :password, :password_confirmation,
        project_option_attributes: [:id, :option_index, :name, :price, :project_id, :remarks, :_destroy]
        )
    end
    
    def set_project_option_params(project)
      params[:project][:project_option_attributes].each_with_index do |project_option, index|
        params[:project][:project_option_attributes]["#{index}"].store("option_index", "#{index+1}")
        params[:project][:project_option_attributes]["#{index}"].store("project_id", "#{project.id}")
      end
    end
end
