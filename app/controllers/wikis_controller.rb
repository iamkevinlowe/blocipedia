class WikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    @wiki = Wiki.new
  end

  def show
    @wiki = Wiki.find(params[:id])
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
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "\"#{@wiki.title}\" was updated successfully."
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
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

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
