class UsersController < ApplicationController

  before_action :ensure_current_user, only: [:edit,:update]

  def index
    @book_new = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @book_new = Book.new
    @user = User.find(params[:id])
    @user_books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  protected

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_current_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end

end
