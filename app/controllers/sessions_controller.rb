class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by_email(params[:email])
      # If user password is correct
      if @user.authenticate(params[:password])
        # Add user_id to session
        session[:user_id] = @user.id
        flash.now[:success] = "Login successfully"
        redirect_to incoming_messages_path
      else
        flash.now[:error] = "Incorrect password"
        render 'new'
      end
    else
      flash.now[:error] = "Users not found"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:success] = "Logged out successfully. Come back again"
    redirect_to root_path
  end

  def callback
    if user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      flash.now[:success] = "Login successfully"
      redirect_to incoming_messages_path
    else
      flash.now[:error] = "Cant login! #{user.errors.full_messages.to_sentence}"
      render 'new'
    end
  end
end
