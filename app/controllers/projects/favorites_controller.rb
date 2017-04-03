class Projects::FavoritesController < ProjectsController

  before_action :set_user
  before_action :set_project

  # POST /users
  def create
    @projects = Project.all
    project = Project.find_by_id(params[:project_id])
    respond_to do |format|
      @user.favorite_project(project)
      if @user.save
        format.js
        format.html{
          flash.now[:notice] = "Project #{@project.name} has been favorited!."
          redirect_to project_path(@project)
        }
      else
        format.js
        format.html{
          flash.now[:notice] = "Erron on favorite project #{@project.name}."
          redirect_to project_path(@project)
        }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @projects = Project.all

    respond_to do |format|
      if @user.favorited_projects.delete(@project)
        format.js
        format.html{
          flash.now[:notice] = "Project #{@project.name} has been disfavorited!."
          redirect_to project_path(@project)
        }
      else
        format.js
        format.html{
          flash.now[:notice] = "Erron on disfavorite project #{@project.name}."
          redirect_to project_path(@project)
        }
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
