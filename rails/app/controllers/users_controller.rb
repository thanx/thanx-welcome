class UsersController < ApplicationController
  before_filter :find_user, except: :index
  def index
    @users = User.all.order(:first_name)
  end

  def show
  end

  def edit
  end

  private
    def find_user
      @user = User.find_by(id: params[:id])
    end
end
