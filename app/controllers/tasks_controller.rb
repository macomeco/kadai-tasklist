class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
        @tasks = Task.all
    end
    
    def show
    end
    
    def new
        @task = Task.new
    end
    
    def create
    @task = Task.new(task_params)
    
    if @task.save
        flash[:success] = 'たすくを追加したよ'
        redirect_to @task
    else
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
        @task = Task.find(params[:id])
    end
    def task_params
        params.require(:task).permit(:content, :status)
    end
end
