class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:destroy, :edit, :show]
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
        if logged_in?
            @task = current_user.tasks.build
            @tasks = current_user.tasks.order(id: :desc)
        end
    end
    
    def show
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        #@task = Task.new(task_params)
        
        if @task.save
            flash[:success] = 'たすくを追加したよ'
            redirect_to root_url
        else
            @tasks = current_user.tasks.order(id: :desc)
            flash.now[:danger] = 'たすくは追加できなかったよ'
            render :new
        end
    end
    
    def edit
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = 'こうしんしたよ'
            redirect_to @task
        else
            flash.now[:danger] = 'こうしんされなかったよ'
            render :edit
        end
    end

    def destroy
        @task.destroy
        flash[:success] = 'さくじょしたよ'
        redirect_to tasks_url
    end
    
    private
    
    
    def set_task
        @task = current_user.tasks.find_by(id: params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
        redirect_to root_url
        end
    end
end