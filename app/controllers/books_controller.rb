class BooksController < ApplicationController
  def new
     @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book.id)
    else
      @books = Book.page(params[:page]).reverse_order
      @user = current_user
      render :index
    end

  end

  def index
    # @books = Book.all　投稿したものを表示する。
    # @books = Book.all.sort {|a,b| b.favorites.count <=> a.favorites.count} いいね数の順番に投稿を表示。
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort {|a,b|
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
      }
    @book = Book.new
    @user=current_user
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @post_comment = PostComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = 'You have updated book successfully.'
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

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
