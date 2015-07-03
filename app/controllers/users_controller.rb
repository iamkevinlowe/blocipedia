class UsersController < ApplicationController
  def show
    @wikis = current_user.wikis.all
    @wiki = current_user.wikis.new
  end
end