class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
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
      params.require(:user).permit(:name, :email, :password)
    end
end
