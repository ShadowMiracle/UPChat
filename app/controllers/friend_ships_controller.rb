class FriendShipsController < ApplicationController
  def new
  end

  def create
    @friend_ship = current_user.friend_ships.build(:friend_id => params[:friend_id])

    respond_to do |format|
      if @friend_ship.save
        flash[:success] = 'Add friends success'
        format.html { render :new }
      else
        flash.now[:error] = "Unable to add friend. #{@friend_ship.errors.full_messages.to_sentence}"
        format.html { render :new }
      end
    end
  end

  def destroy
    @friend_ship = current_user.friend_ships.where(friend_id: params[:friend_id])

    respond_to do |format|
      if @friend_ship.destroy_all
        flash.now[:success] = 'Remove friends successfully'
        format.html { render :new }
      else
        flash.now[:error] = 'Some error happen. Try again later'
        format.html { render :new }
      end
    end
  end
end
