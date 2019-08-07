class PostsController < ApplicationController
  
  before_action :move_to_index, except: :index
  
  def index
    @posts = Post.includes(:user).order("created_at DESC")
    @post = Post.new
  end
  
  def new 
  end 

  def create
    Post.create(name: posts_params[:name],text: posts_params[:text], date: posts_params[:date], user_id: current_user.id)
    @posts = Post.all
  end
  
  def destroy
    Post.find(params[:id]).destroy
    @posts = Post.all
  end

  private
  def posts_params
    params.require(:post).permit(:text)
  end
  
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end