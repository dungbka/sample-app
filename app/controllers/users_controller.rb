class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  attr_reader :user

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if user.save
      user.send_activation_email
      flash[:info] = t "mailer.please_check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    if user
      @microposts = user.microposts.order_desc.paginate page: params[:page]
    else
      flash[:danger] = t "url_invaild"
      redirect_to root_url
    end
  end

  def edit; end

  def update
    if user.update_attributes user_params
      flash[:success] = t "users.update.profile_update"
      redirect_to user
    else
      render :edit
    end
  end

  def destroy
    user.destroy
    flash[:success] = t "users.destroy.user_delete"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    redirect_to root_url unless user.current_user? current_user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    flash[:danger] = t "not_exits_user"
    redirect_to root_path
  end
end
