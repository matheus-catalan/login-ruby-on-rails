class UsersController < ApplicationController
    before_action :authorized, only: [:validate, :index, :show, :update, :delete]
  
    def create
      @user = User.create(user_params)
      if @user.valid?
        render json: {user: @user}
      else
        render json: {error: "Invalid email or password"}
      end
    end

    def index 
      @payload = User.all
      @users = []

      @payload.map{|user| (
        p = 'no-img.jpeg'
        if (user.photo.persisted?)
          p = url_for(user.photo)
        end
        @users << {:id => user.id, :name => user.name, :email => user.email, :created_at => user.created_at.strftime("%d/%m/%Y"), :photo => p}
      )}

      render json: {
        users: @users
      } 
    end

    def show  
      p = 'no-img.jpeg'
      if (@user.photo.persisted?)
        p = url_for(@user.photo)
      end
      render json: {
        user: @user,
        photo: p
      }
    end

    def update
      @user = User.find(@user.id)
      if params[:photo] == 'null'
        @user.update(name: params[:name], email: params[:email])
    
        render json: {
          name: @user.name,
          email: @user.email
        }, status: 200
      else
        @user.update(name: params[:name], email: params[:email], photo: params[:photo])

        render json: {
          name: @user.name,
          email: @user.email,
          photo: url_for(@user.photo)
        }, status: 200
      end       
    end

    def delete
      User.find(params[:userId]).destroy
      
      render status: 200
    end
  
    def login
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        
        p = 'no-img.jpeg'
        if (@user.photo.persisted?)
          p = url_for(@user.photo)
        end

        token = encode_token({user_id: @user.id})
        render json: 
        {
          user: {
            name: @user.name, email: @user.email, photo: p
          }, 
          token: token
        }
      else
        render json: {
          error: "Invalid email or password",
        }, status: 401
      end
    end

    def forgotPassword
      @user = User.find_by(email: params[:email])
      token = SecureRandom.hex(4)
      @user.update(token_forgot_password: token, date_forgot_password: Date.current)
      UserMailer.forgotPassword(@user, token).deliver
    end

    def forgotPasswordSave
      @user = User.find_by(token_forgot_password: params[:tokenForgotPassword])
      print @user.name

      @user.update(token_forgot_password: nil, date_forgot_password: nil, password: params[:password])
    end
  
    
    def validate
      render json: @user
    end
  
    private
  
    def user_params
      params.permit(:name, :email, :password, :photo)
    end
  
  end