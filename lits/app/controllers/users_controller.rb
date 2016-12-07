class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  # GET /feed/edit
  def edit
    redirect_to root_path if @user.nil?
  end

  # PATCH/PUT /feed/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        logger.debug(user_params)
        format.html { redirect_to user_edit_path, notice: 'Ваша лента обновлена' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    # @user = User.find(params[:id])
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    accessible = [:name, :email, :avatar, :image, all_tags: [], category_ids: []]
    params.require(:user).permit(accessible)
  end
end
