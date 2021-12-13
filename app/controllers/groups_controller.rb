class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def index
    @book=Book.new
    @groups=Group.all
  end

  def edit
    @group=Group.find(params[:id])
  end

  def update
    @group=Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      reder :edit
    end
  end

  def show
    @group=Group.find(params[:id])
    @book=Book.new
  end

  def new_mail
    @group = Group.find(params[:group_id])
  end

  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@mail_title, @mail_content,group_users).deliver
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image )
  end
end
