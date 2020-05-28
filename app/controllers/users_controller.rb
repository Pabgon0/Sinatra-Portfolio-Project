class UsersController < ApplicationController

    get "/signup" do
      if logged_in?
        erb :"/users/home"
      else
        erb :"/users/signup"
      end
    end
  
    post "/signup" do
      if params[:username]=="" || params[:password]==""
        erb :"/errors/signup_error"
      end
      user = User.new(:username => params[:username], :password => params[:password])
      if user.save
        redirect "/login"
      else
        erb :"/errors/signup_error"
      end
    end
  
    get "/signup_return" do
      erb :"/users/signup"
    end
  
    get "/login" do
      if logged_in?
        erb :"/users/home"
      else
        erb :"/users/login"
      end
    end
  
    post "/login" do
      @user = User.find_by(:username => params[:username])
  
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        erb :"/users/home"
      else
        erb :"/errors/login_error"
      end
    end
  
    get "/login_return" do
      erb :"/users/login"
    end
  
    get "/logout" do
      if logged_in?
        session.clear
        redirect "/"
      end
    end
  
    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :"users/home"
    end
  
  end