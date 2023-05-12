class PagesController < ApplicationController
    def home
        @user = User.find(session[:user_id]);
        session[:username] = @user.username
        session[:user_id]= @user.id
        redirect_to articles_url
    end
end