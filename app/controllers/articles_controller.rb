class ArticlesController < ApplicationController
    before_action :set_article, only: %i[ show edit update destroy ]

    def index
        # @articles = User.find(session[:user_id]).articles
        @articles = Article.all
    end

    def show
    end

    def new
        @article = Article.new
    end

    def edit
    end

    def my_blog
        @articles = User.find(session[:user_id]).articles
        render(:index, status:422)
    end

    def all_articles_by_user
        @articles = User.find(params[:id]).articles
        render(:index, status:422)
    end

    def create
        @article = Article.new(article_params)
        @article[:user_id] = session[:user_id]
        respond_to do |format|
            if @article.save
                format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
                format.json { render :show, status: :created, location: @article }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @article.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        if(session[:user_id] == @article.user_id)
            respond_to do |format|
                if @article.update(article_params)
                format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
                format.json { render :show, status: :ok, location: @article }
                else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @article.errors, status: :unprocessable_entity }
                end
            end
        else
            redirect_to articles_url, alert: "Invaild User"
        end
    end

    def destroy
        @article.destroy
        respond_to do |format|
            format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      begin
        @article = Article.find(params[:id])
      rescue => exception
        redirect_to articles_path, notice: exception
      end
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :description)
    end

end