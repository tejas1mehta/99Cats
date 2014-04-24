class UsersController < ApplicationController
  before_action :to_root_if_curr_user, only: :new

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
    else
      flash.now[:errors] = @users.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
