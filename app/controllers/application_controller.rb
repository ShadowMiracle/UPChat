class ApplicationController < ActionController::Base
  require 'digest/sha1'
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :signed_in
  helper_method :require_login
  helper_method :skip_if_logged_in
  helper_method :user_list
  helper_method :friend_list
  helper_method :not_friend_list
  helper_method :time_different_to_now

  protected
    def current_user
      return @current_user if @current_user
      if session[:user_id]
        @current_user = User.find(session[:user_id])
      end
    end

    def signed_in
      if session[:user_id].nil?
        return false
      else
        return true
      end
    end

    def require_login
      if !signed_in
        flash[:error] = "You must login to view content!"
        redirect_to root_path
      end
    end

    def user_list
      User.where.not(id: current_user.id)
    end

    def friend_list
      current_user.friends
    end

    def not_friend_list
      if current_user.friends.nil?
        User.all
      else
        User.where.not(id: friend_list.collect {|f| f.id } + [current_user.id])
      end

    end

    def skip_if_logged_in
      if signed_in
        redirect_to new_message_path
      end
    end

    def time_different_to_now(message)
      @different = Time.now - message.created_at

      if @different < 60
        return 'Just now'
      elsif @different < 60*60
        return "#{(@different/60).round} min ago"
      else
        return message.created_at.strftime("%H:%m")
      end
    end
end
