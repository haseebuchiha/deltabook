class FriendsController < ApplicationController
  before_action :require_user
  def create
    @user=User.find_by(username: params[:friend][:username])
    byebug
    if @user
    if !current_user.friends.include?(@user) && !@user.friends.include?(current_user)
      @user.friends << current_user
      current_user.friends << @user
      redirect_to friends_show_path
    else
      flash[:alert] = "You Are Already Friend"
      redirect_to friends_show_path
    end

    else
      flash[:alert] = "User Not Found"
      redirect_to friends_new_path
    end


  end
  def new

  end

  def show
    @all_friends = current_user.friends
  end
end
