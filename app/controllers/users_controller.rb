class UsersController < ApplicationController
  def show
    @wikis = current_user.wikis.paginate(page: params[:page], per_page: 10)
    @wiki = Wiki.new
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated."
      redirect_to current_user
    else
      flash[:error] = "There was an error updating user information."
      redirect_to current_user
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :role)
  end
end
