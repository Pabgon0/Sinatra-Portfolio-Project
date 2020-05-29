class ReviewsController < ApplicationController
  get "/reviews" do
    if logged_in?
      @user = current_user
      erb :"/reviews/reviews"
    end
  end

  get "/reviews/new" do
    if logged_in?
      erb :"/reviews/new"
    end
  end

  post "/reviews" do
    if logged_in?
      if params[:game_title] == "" || params[:content] == ""
        redirect "/errors/missing_data"
      else
        @review = current_user.reviews.create(:game_title => params[:game_title], :content => params[:content])
        @review.save
        redirect "/reviews/#{@review.id}"
      end
    end
    current_user.save
  end

  get "/errors/missing_data" do
    erb :"/errors/missing_data"
  end

  get "/reviews/:id" do
    if logged_in?
      @review = Review.find_by_id(params[:id])
      erb :"/reviews/show"
    end
  end

  get "/reviews/:id/view_all" do
    if logged_in?
      erb :"/reviews/user_reviews"
    end
  end

  get "/reviews/:id/edit" do
    if logged_in?
      @review = Review.find_by_id(params[:id])
      if @review && @review.user == current_user
        erb :"/reviews/edit"
      end
    end
  end

  patch "/reviews/:id" do
    if logged_in?
      if params[:game_title] == "" || params[:content] == ""
        redirect "/reviews/#{params[:id]}/edit"
      else
        @review = Review.find_by_id(params[:id])
        if @review && @review.user == current_user
          if @review.update(:game_title => params[:game_title], :content => params[:content])
            redirect "/reviews/#{@review.id}"
          else
            redirect "/reviews/#{@review.id}/edit"
          end
        else
          redirect to "/reviews"
        end
      end
    end
  end

  delete "/reviews/:id/delete" do
    if logged_in?
      @review = Review.find_by_id(params[:id])
      if @review && @review.user == current_user
        @review.delete
      end
      redirect "/reviews"
    end
  end
end