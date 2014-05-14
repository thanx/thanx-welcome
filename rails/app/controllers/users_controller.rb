class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :find_user, only: [:edit, :show, :update]

  def index
    @users = User.all.order(:first_name)
  end

  def show
  end

  def new
    @user = User.new
    render "edit" and return
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)
    if @user.errors.present?
      flash[:error] = @user.errors.messages
      redirect_to edit_user_path() and return
    end
    redirect_to users_path
  end

  def create
    @user = User.create(user_params)
    if @user.errors.present?
      flash[:error] = @user.errors.messages
      redirect_to new_user_path() and return
    end
    redirect_to users_path
  end

  private
    def find_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
