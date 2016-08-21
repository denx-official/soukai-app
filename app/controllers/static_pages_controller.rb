class StaticPagesController < ApplicationController
  include Common
  before_action :detect_devise_variant
  layout :select_layout
  
  def home
  end

  def help
  end

end
