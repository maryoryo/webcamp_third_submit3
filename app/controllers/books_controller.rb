class BooksController < ApplicationController
  
  before_action :ensure_current_user, only: [:edit, :update]
  
  def index
    @book_new = Book.new
    @user = current_user
    @books = Book.all
  end

  def create
    @book_new = Book.new(books_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      @books = Book.all
      @user = @book_new.user
      render :index
    end
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @book_user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  
  protected
  
  def books_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_current_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
  
end
