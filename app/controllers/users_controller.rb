class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

	def index
    redirect_to '/users/sign_in' unless user_signed_in?
    redirect_to edit_user_path(current_user.id) unless current_user.is_admin
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context, current_user, params) }
    end
	end

  def new
    redirect_to edit_user_path(current_user.id) unless current_user.is_admin
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid? && @user.save!
      redirect_to({ action: 'index' }, notice: 'User was successfully created.')
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    params[:id] = current_user.id unless current_user.is_admin #restricting to edit other user details
  end

  def update
    if @user.update(user_params)
      bypass_sign_in(current_user) if @user == current_user
      redirect_to(current_user.is_admin ? users_path : edit_user_path(current_user.id), notice: 'User was successfully updated.')
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      redirect_to(edit_user_path)
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :address, :phone_number, :profile_picture, :is_admin, :password, :password_confirmation)
  end
end
