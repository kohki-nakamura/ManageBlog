class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    params[:display_count] ||= 10
    @users = User.search(params[:search]).page(params[:page]).per(params[:display_count])
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to [:admin, @user], notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to [:admin, @user], notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url(page: params[:page]), notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def export_csv
    respond_to do |format|
      format.csv do
        send_data User.to_csv,
        type: 'text/csv; charset=utf-8',
        filename: "users_#{Time.now.strftime("%Y_%m_%d_%H_%M_%S")}.csv"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {}).permit(:last_name, :first_name, :birthday, :gender, :phone, :zipcode, :address, :is_admin, :email, :password)
    end
end
