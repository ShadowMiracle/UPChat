class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    users_params.avatar_url = "https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/#{1 + rand(5)}_copy.jpg"
    @user = User.new(users_params)

    if (@user.save)
      flash[:success] = "Create user successfully"
      redirect_to incoming_messages_path
    else
      render 'new'
    end
  end

  private
    def users_params
      @users_params ||= params.require(:user).permit(:name, :email, :password)
    end
end
