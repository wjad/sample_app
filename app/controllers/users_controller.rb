class UsersController < ApplicationController
  
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only:[:edit, :update]

  def index
     @users = User.paginate(page: params[:page])
  end

  def show
  	#Lesson 7
  	 @user = User.find(params[:id])
  end

  def new

  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save

      sign_in @user
  		flash[:success]= "Welcome to the Sample App"
  		#there is a shortcut for the following Ruby code
  		#redirect_to user_path(@user)
  		redirect_to @user
  		else
      render 'new'
    end 
	end

  #this action is to populate the edit page
  def edit
    #Lesson 9
    # @user = User.find(params[:id]) #commented out and moved down to correct_user
  end

  #this action is to update values in the edit page
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success]= "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # private
  #   def signed_in_user
  #     flash[:notice]= "Please sign in."
  #      redirect_to signin_path unless signed_in?
  #   end
  #Re-written in Lesson 09
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)

    end

end