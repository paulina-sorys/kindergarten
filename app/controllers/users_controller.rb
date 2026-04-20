class UsersController < ApplicationController

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      head :ok
    else
      head :bad_request
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find_by(id: params[:id])

    if @user
      @user.destroy
      head :ok
    else
      head :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
