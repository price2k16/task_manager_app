class TasksController < ApplicationController
  before_action :authenticate_user!  # Ensures user is authenticated before accessing any actions
  before_action :set_task, only: [:show, :edit, :update, :destroy]  # DRY: Finds the task for certain actions

  def index
    @tasks = current_user.tasks  # Only the tasks belonging to the current user
  end
  
  def show
    # Already handled by `set_task`, only shows the task for the current user
  end

  def new
    @task = current_user.tasks.new  # Ensures new task is associated with the current user
  end

  def create
    @task = current_user.tasks.new(task_params)  # Creates a new task for the current user
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new  # If saving fails, render the new task form again
    end
  end

  def edit
    # Already handled by `set_task`, ensures the task belongs to the current user
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit  # If update fails, render the edit form again
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'  # Redirect after task deletion
  end

  private

  # Finds the task for actions that need it (show, edit, update, destroy)
  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
    if @task.nil?
      redirect_to tasks_url, alert: 'Task not found or you do not have permission to view/edit it.'
    end
  end

  # Strong parameters: Only allows permitted attributes for tasks
  def task_params
    params.require(:task).permit(:title, :description)  # Permits only title and description for security
  end
end


