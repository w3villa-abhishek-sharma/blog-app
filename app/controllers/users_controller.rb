class UsersController < ApplicationController
    
    def new
        @user = User.new
    end

    def login
    end

    def edit
        @user = User.find(session[:user_id])
    end
    
    def profile
        @user = User.find(session[:user_id])
    end

    def update
        @user = User.find(session[:user_id]);
        if @user.update(user_params)
         redirect_to "/", notice: "Your profile updated successfully."
        end
    end

    def all_user
        @users = User.all
    end

    def login_verification
        username = params[:session][:username]
        password = params[:session][:password]

        user = User.find_by(username: username.downcase)
        if(user && user.authenticate(password))
            session[:username] = user.username
            session[:user_id] = user.id
            redirect_to "/"
        else
            redirect_to "/login" ,alert: "Invalid Data."
        end
    end

    def create
        @user = User.new(user_params)
        
        respond_to do |format|
            if @user.save
                format.html { redirect_to "/login", notice: "You are register successfully." }
                format.json { render :show, status: :created, location: @user }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @article.errors, status: :unprocessable_entity }
            end
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email,:password)
    end

end