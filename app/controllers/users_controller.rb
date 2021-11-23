class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new

  end
  
  def index
    @users = User.page(params[:page]).reverse_order
    @user = current_user
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new
    
  end
  
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path
    else
      @user = User.page(params[:page]).reverse_order
      render :index
    end
  end
  
  def follower
    user = User.find(params[:id])
    @users = user.followers
  end
  
  def followed
    user = User.find(params[:id])
    @users = user.followeds
  end
  
  def search
    @user = User.find(params[:user_id])
    @books = @user.books 
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"#①
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count#②
    end
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
