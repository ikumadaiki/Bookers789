class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new
    @today_book =  @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    @created_6daysago = @books.created_6daysago.count
    @created_5daysago = @books.created_5daysago.count
    @created_4daysago = @books.created_4daysago.count
    @created_3daysago = @books.created_3daysago
    @created_2daysago = @books.created_2daysago
    @created_yesterday = @books.created_yesterday
    @created_today = @books.created_today
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


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
