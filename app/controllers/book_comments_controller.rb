class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @user = @book.user
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment.save
    @book_comment = BookComment.new
    #redirect_to book_path(@book), notice: '投稿に成功しました
    #redirect_to book_path(@book
  end




  def destroy
    @book = Book.find(params[:book_id])
    @user = @book.user
    @bookcomment = BookComment.find(params[:id])
    @bookcomment.destroy
    @bookcomment = BookComment.new
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
