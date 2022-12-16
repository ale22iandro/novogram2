class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  before_action :set_comment, only: :destroy



  # GET /comments or /comments.json
  def index
    @comments = Comment.where(user_id: current_user.id)
  end

  # POST /comments or /comments.json
  def create
    # Создаём объект @new_comment из @post
    @new_comment = @post.comments.build(comment_params)
    # Проставляем пользователя, если он задан
    @new_comment.user = current_user

    if @new_comment.save
      # Если сохранился, редирект на страницу самого post
      redirect_to @post, notice: 'comments created'
    else
      # Если ошибки — рендерим здесь же шаблон события (своих шаблонов у коммента нет)
      render 'posts/show', alert: 'error'
    end
  end

  def destroy
    message = {notice: 'destroyed'}

    if current_user == @comment.user || current_user == @post.user
      @comment.destroy!
    else
      message = {alert: 'error'}
    end

    redirect_to @post, message
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:post_id])
  end

  # Комментарий будем искать не по всей базе,
  # а у конкретного post
  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body, :username)
  end
end
