class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end
    
    def show
        @article = Article.find(params[:id]) # in ruby no return statement, returns last evaluated statement || also takes param id
    end

    def new
        @article = Article.new # if article is errouneous -> shows errors in new view
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(article_params) # secure pattern | strong parameters tells which 
                                                                               # params are allowed into our controller actions

        if @article.save
            redirect_to @article
        else
            render 'new' # render new view
        end
    end

    def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end

    private
        def article_params
            params.require(:article).permit(:title, :text)
        end
end
