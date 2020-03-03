class UsersController < ApplicationController
#ユーザの一覧、詳細は必要なし... index,showはいらない
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "とうろくしたよ"
      redirect_to root_url
    else
      flash.now[:danger] = 'とうろくしっぱいしちゃった...'
      render :new
    end
  end
  #ゆーざーの情報をしゅとく！
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
