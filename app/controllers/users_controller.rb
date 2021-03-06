class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /users
  # GET /users.json
  def index
    # @users = User.all
    @q = User.search(params[:q])
    @users = @q.result.page(params[:page]).per(15)

    @totNumber = User.all.count
    @searchNumber = @q.result.count

    authorize @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    authorize @user

    # Generate the 2d array needed for grouped select in view
      @grouped_options = ForSelect.GroupedSelect('9999','facility', ForSelect)
  end

  # GET /users/1/edit
  def edit
    # Generate the 2d array needed for grouped select in view
      @grouped_options = ForSelect.GroupedSelect('9999','facility', ForSelect)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    authorize @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      authorize @user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :authen, :facility, :role, :email, :firstinitial, :middleinitial, :updated_by)
    end
end
