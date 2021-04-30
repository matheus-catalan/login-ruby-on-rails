class UsersController < ApplicationController
    before_action :authorized, only: [:validate]
  
    def create
      @user = User.create(user_params)
      if @user.valid?
        render json: {user: @user}
      else
        render json: {error: "Invalid email or password"}
      end
    end
  
    def login
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        token = encode_token({user_id: @user.id})
        render json: 
        {
          user: {
            name: @user.name, email: @user.email
          }, 
          token: token
        }
      else
        render json: {error: "Invalid email or password"}
      end
    end

    def forgotPassword
      @user = User.find_by(email: params[:email])
      token = SecureRandom.hex(4)
      @user.update(token_forgot_password: token, date_forgot_password: Date.current)
      UserMailer.forgotPassword(@user, token).deliver
    end

    def forgotPasswordSave
      print '---------------------------------------------------------------------------------'
      print params
      print '---------------------------------------------------------------------------------'

      @user = User.find_by(token_forgot_password: params[:tokenForgotPassword])
      print @user.name

      @user.update(token_forgot_password: nil, date_forgot_password: nil, password: params[:password])
    end
  
    
    def validate
      render json: @user
    end
  
    private
  
    def user_params
      params.permit(:name, :email, :password)
    end
  
  end