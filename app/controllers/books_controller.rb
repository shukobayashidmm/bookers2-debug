class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @book_comment = BookComment.new
    @books = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @book_comment = BookComment.new
    @book = Book.new
    @books = Book.all
    @books = Book.includes(:favorited_users).sort { |a,b| b.favorited_users.size <=> a.favorited_users.size }
  end

  def create
    @book_comment = BookComment.new
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    @book = @book.user
    unless @book == current_user
      redirect_to books_path
    end
  end
end
