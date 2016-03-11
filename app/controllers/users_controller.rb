class UsersController < ApplicationController
  before_action :logged_in_user,     only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,       only: [:show, :edit, :update, :destroy]
  before_action :admin_user,         only: [:index]

  def index
    @users = User.paginate(page: params[:page]).order(:name)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.send_activation_email
        format.html {
                      redirect_to root_url,
                      info: "Please check your email to activate your account."
                    }
        # format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, success: "Profile updated" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless (current_user?(@user) || current_user.admin?)
      rescue ActiveRecord::RecordNotFound
        redirect_to root_url  #prevents friendly forwarding from showing 404 pages
    end

    def admin_user
      @user = current_user
      redirect_to(root_url) unless @user.admin?
    end
end
