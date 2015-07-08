class CollaboratorsController < ApplicationController
  def create
    @collaborator = Collaborator.new(collaborator_params)
    @wiki = Wiki.find(params[:collaborator][:wiki_id])
    if @collaborator.save
      flash[:notice] = "Collaborator added successfully."
      redirect_to @wiki
    else
      flash[:error] = "Something went wrong."
      redirect_to @wiki
    end
  end

  def destroy
    @collaborator = Collaborator.find_by_user_id_and_wiki_id(params[:collaborator][:user_id], params[:collaborator][:wiki_id])
    @wiki = @collaborator.wiki
    if @collaborator.delete
      flash[:notice] = "Collaborator removed successfully."
      redirect_to @wiki
    else
      flash[:error] = "Something went wrong."
      redirect_to @wiki
    end
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end

end
