class PostsController < ApplicationController
  def index
    @posts = Post.all
    @favorite_posts = current_user.favorited_by_type('Post')
  end

  def like
    @post = Post.all.find(params[:id])
    if @post.liked?(current_user)
      @post.likes.find_by(user_id: current_user.id).destroy
    else
      Like.create(user_id: current_user.id, post_id: @post.id)
    end

    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    #@new_comment = @post.comments.build(params[:comment])
    @post = Post.find(params[:id])
  end

  def create
    Post.create(post_params)
    redirect_to root_path
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:description, :image, :user_id)
  end
end
