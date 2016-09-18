class VotesController < ApplicationController
  include Common
  layout        :select_layout
  before_action :logged_in_user, only: [:new, :create]
  
  def new
    soukai_id = Soukai.narrow_year(Date.today.year).map(&:id)
    @projects = Project.where(soukai_id: soukai_id).order("id desc")
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
  
  private
      # ログイン済みユーザーかどうか確認
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end
    
    def detail_areas_select
      # ajax によるリクエストの場合のみ処理
      if request.xhr?
        if params[:store_id].present? && params[:store_id].to_s != 'stores'
          store = Store.find(params[:store_id])
        else
          store = Store.new
        end
        detail_ares = Detail_area.select(:id, :name).where(pref_id: params[:pref_id])
        render partial: '/stores/form_detail_areas', locals: { store: store, detail_areas: detail_areas}
      end
    end
end
