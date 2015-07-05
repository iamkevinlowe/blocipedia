class UsersController < ApplicationController
  def show
    private_check
    @wikis = policy_scope(Wiki).select{|wiki|
      (wiki.user_id == current_user.id) ||
      (wiki.users.include?(current_user))
      }.paginate(page: params[:page], per_page: 10)
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

  def private_check
    Wiki.where(user_id: current_user.id).where(private: true).update_all(private: false) if current_user.standard?
  end

  private

  def user_params
    params.require(:user).permit(:name, :role)
  end
end
