class Projects::UsersController < ProjectsController

  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:update]
  before_action :authorize

  # GET /users
  def index
    @project = Project.all.find(params[:project_id])
  end

  # GET /users/1
  def show
    redirect_to project_users_path, notice: 'Done.'
  end

  # GET /users/new
  def new
    @project = Project.all.find(params[:project_id])
  end

  # GET /users/1/edit
  def edit

  end

  # POST /users
  def create
    @project = Project.all.find(params[:project_id])
    @user = User.find_by_email(params[:email])
    if @user
      @project.owners << @user
      redirect_to project_users_path
    else
      flash.now[:error] = "No user matches with this e-mail."
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update_attributes(user_params)
      respond_to do |format|
        format.json { render :json => { :status => 'Ok', :message => 'Received'}, :status => 200 }
      end
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @project = Project.all.find(params[:project_id])
    @user = @project.owners.find(params[:id])
    if @project.owners.delete(@user)
      redirect_to project_users_path, notice: 'Done.'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit!
  end

  def set_project
    @project = Project.all.find(params[:project_id])
      #@project = current_user.projects.find(params[:id])
  end

end
