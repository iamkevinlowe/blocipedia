class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki).paginate(page: params[:page], per_page: 10)
    @wiki = Wiki.new
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    @collaborators = Collaborator.where(wiki_id: @wiki.id)
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki
    if @wiki.save
      flash[:notice] = "\"#{@wiki.title}\" was saved successfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error creating the wiki. Please try again."
      render :new
    end

  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    @users = users_for_form_select
    @collaborator = Collaborator.new
    @collaborators = collaborators_for_form_select
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "\"#{@wiki.title}\" was updated successfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    if @wiki.delete
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      @wiki = Wiki.new
      render :index
    else
      flash[:error] = "There was an error deleting the wiki. Please try again."
      redirect_to @wiki
    end
  end

  private

  def users_for_form_select
    exclude = @wiki.users.pluck(:id)
    exclude << @wiki.user.id
    users = User.where.not(id: exclude).pluck(:name, :id)
  end

  def collaborators_for_form_select
    collaborators = []
    @wiki.collaborators.each{|collaborator| collaborators << [collaborator.user.name, collaborator.user.id]}
    collaborators
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, collaborator_attributes: [:id, :user_id])
  end
end
