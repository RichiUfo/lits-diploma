class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,:finish_signup]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new

  # GET /users/1/edit
  def edit
    redirect_to '/events#index' if @user.nil?
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new_user_registration_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def finish_signup
    if request.patch? && params[:user]
      if @user.update(user_params)
        @user.skip_reconfirmation!

        sign_in(@user, :bypass => true)
        redirect_to @users, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
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
      accessible = [ :name, :email,:avatar, :image, :all_tags, category_ids:[]]
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end
