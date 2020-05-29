class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      erb :"/index"
    else
      erb :"/users/signup"
    end
  end

  post "/signup" do
    if params[:username]=="" || params[:password]==""
      redirect "signup_error"
    end
    if !User.new(:username => params[:username], :password => params[:password]).valid?
      redirect "signup_taken"
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect "/login"
    end
  end

  get "/signup_return" do
    erb :"/users/signup"
  end

  get "/signup_error" do
    erb :"/errors/signup_error"
  end

  get "/signup_taken" do
    erb :"/errors/signup_taken"
  end

  get "/login" do
    if logged_in?
      erb :"/index"
    else
      erb :"/users/login"
    end
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/home"
    else
      redirect "/login_error"
    end
  end

  get "/login_return" do
    erb :"/users/login"
  end

  get "/login_error" do
    erb :"/errors/login_error"
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/"
    end
  end

  get "/home" do
    erb :"/index"
  end

  get "/users/:slug" do
   @user = User.find_by_slug(params[:slug])
   erb :"users/index"
  end
end