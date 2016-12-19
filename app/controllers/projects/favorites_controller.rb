class Projects::FavoritesController < ProjectsController

  before_action :set_user
  before_action :set_project

  # POST /users
  def create
    project = Project.find_by_id(params[:project_id])
    respond_to do |format|
      @user.favorited_projects << project
      if @user.save
        flash.now[:notice] = "Project #{@project.name} has been favorited!."
        format.js
        format.html
      else
        flash.now[:notice] = "Erron on favorite project #{@project.name}."
        format.js
        format.html
      end
    end
  end
  
  # DELETE /users/1
  def destroy
    respond_to do |format|
      if @user.favorited_projects.delete(@project)
        flash.now[:notice] = "Project #{@project.name} has been disfavorited!."
        format.js
        format.html
      else
        flash.now[:notice] = "Erron on disfavorite project #{@project.name}."
        format.js
        format.html
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

end