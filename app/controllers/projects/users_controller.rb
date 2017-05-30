class Projects::UsersController < ProjectsController

  before_action :set_project, only: [:index, :destroy, :new, :create]
  before_action :set_user, only: [:show, :update, :destroy]

  skip_before_filter :verify_authenticity_token, only: [:update]
  before_action :authorize

  # GET /users
  def index
    @project = Project.all.find(params[:project_id])
  end

  # GET /users/new
  def new
  end

  # POST /users
  def create
    @user = User.find_by_email(params[:email])
    if @user
      @project.owners << @user
      redirect_to project_users_path, success: "#{@user.username} is a owner now."
    else
      flash.now[:error] = "No user matches with this e-mail."
      render :new
    end
  end

  # DELETE /users/1
  def destroy
    if current_user == @user && @project.owners.count == 1
      redirect_to project_users_path, error: 'You cannot delete yourself because you are the unique owner of this project.'
    else
      if @project.owners.delete(@user)
        redirect_to project_users_path, notice: 'Done.'
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = @project.owners.find_by_username(params[:id])
  end
  def set_project
    @project = Project.all.find(params[:project_id])
  end

end
