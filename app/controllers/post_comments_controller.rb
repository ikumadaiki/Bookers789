class PostCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.book_id = @book.id
    comment.save
    
    #redirect_to book_path(book)を削除
  end

  def destroy
    @book = Book.find(params[:book_id])
    #@book = Book.find(params[:book_id])を追加
    PostComment.find_by(id: params[:id]).destroy
    
    #redirect_to book_path(params[:book_id])を削除
  end
  
    private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
