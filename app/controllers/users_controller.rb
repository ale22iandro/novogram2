class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def subscribe
    @user = User.all.find(params[:id])
    new_subscriber = Subscribtion.create(user_id: current_user.id, followed_id: @user.id)
    new_subscriber.save

    EventMailer.subscription(@user.email, @user.name).deliver_now
    redirect_to user_path(@user)
  end


  def unsubscribe
    @user = User.all.find(params[:id])
    Subscribtion.where(user_id: current_user, followed_id: @user.id).destroy_all

    redirect_to user_path(@user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    current_user.update(user_params)
    redirect_to current_user
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :website,
                                 :bio, :email, :phone, :gender, :avatar)
  end
end
