class Projects::OwnershipRequestsController < ProjectsController

  before_action :set_ownership_request, only: [:show, :edit, :update, :destroy]
  before_action :set_project
  # POST /ownership_requests
  def create
    current_user.request_ownership(@project)
    respond_to do |format|
       format.js #this will call delete.js.erb when js action is called
     end
  end

  def update
    if @approved == true
      @ownership_request.approve
    else
      @ownership_request.disapprove
    end

    respond_to do |format|
       format.js #this will call delete.js.erb when js action is called
     end
  end

  #cancel ownership
  def destroy
    @project.dismiss_request_ownership(current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ownership_request
      @ownership_request = OwnershipRequest.find(params[:id])
      @approved = (params[:approved] == "true") # 3 fuckin hours to discovery this
    end

    # Only allow a trusted parameter "white list" through.

    def set_project
      @project = Project.find(params[:project_id])
    end

end
