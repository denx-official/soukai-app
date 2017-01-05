class ShareThingsController < ApplicationController
  include Common
  layout        :select_layout
  before_action :logged_in_user
  before_action :set_content_type, only: [:new, :edit, :update]
  
  def index
    @share_things = ShareThing.all.order("id asc")
  end
  
  def new
    @share_thing = ShareThing.new
  end
  
  def create
    params[:share_thing][:user_id] = current_user.id
    @share_thing = ShareThing.new(share_thing_params)
    if @share_thing.save
      flash[:info] = "共有物が登録されました"
      redirect_to share_things_url
    else
      render 'new'
    end
  end
  
  def edit
    @share_thing = ShareThing.find(params[:id])
  end
  
  def update
    @share_thing = ShareThing.find(params[:id])
    if @share_thing.update_attributes(share_thing_params)
      flash[:success] = "変更されました"
      redirect_to share_things_url
    else
      render 'edit'
    end
  end
  
  def destroy
    ShareThing.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to share_things_url
  end

  private
    def set_content_type
      @content_type = ShareThing::ContentType.pluck(:name, :id)
    end
    
    def share_thing_params
        params.require(:share_thing).permit(:name, :content, :content_type_id, :user_id)
    end

end
