class Web::Admin::Dashboard::UsersController < Web::Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(:role).order('created_at DESC').page params[:page]
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_dashboard_user_path(@user), notice: "User was successfully created." }
        format.json { render json: @user }
      else
        format.html { render 'new' }
        format.json { render json: @user.errors, status: 'unprocessable_entity' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_dashboard_user_path(@user), notice: "User was successfully updated." }
        format.json { render json: @user }
      else
        format.html { render 'edit' }
        format.json { render json: @user.errors, status: 'unprocessable_entity' }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_users_path, notice: "User was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role, :password)
  end
end
