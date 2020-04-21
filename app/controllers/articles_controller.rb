class ArticlesController < ApplicationController
    before_action :find_posts, only: [:show, :update, :edit, :destroy]
    http_basic_authenticate_with  name:"dhh", password: "secret", except: [:index, :show]
    
    def index
        @articles = Article.all.order("created_at DESC") # returns all objects of Article model class
    end
    
    def show # @article is an instance variable which is used to share data between controller and views
        @article = Article.find(params[:id]) # in ruby no return statement, returns last evaluated statement || also takes param id
    end # params is the hash variable that identifies RESTful resource, found in url after resource name

    def new # GET request
        @article = Article.new # if article is errouneous -> shows errors in new view
    end
    # When you ask for the new action, Rails API implementation at a given point 
    # creates an instance of ArticlesController and sends the new message to that instance (calls the new method). 
    # Then, the instance variable @article is created and available in any method, or in any view that the action renders.
    # At a given point, Rails replies with a web page and the class instance, and all its instance variables, are destroyed 
    # (won't be available anymore).

    def edit
        @article = Article.find(params[:id])
    end

    def create # POST request
        @article = Article.new(article_params) # secure pattern | strong parameters tells which params are allowed into our controller actions
        if @article.save
            redirect_to @article
        else
            render 'new' # render new view
        end
    end

    # When you submit the form for database persistence, again a new controller instance is created, and the create method 
    # is called. Because is a new instance, the @articles doesn't have any value.

    # Note, however, that there is a difference between rendering a view (like its happening in the new action) and a 
    # redirect (like you do in the create action if @article.save is true). When you render, you remain in the same 
    # controller instance, with you redirect, new server request happens, so the previous controller instance is 
    # destroyed and a new controller instance is created.

    def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

private
    def find_posts
        @article = Article.find(params[:id])
    end
    def article_params
        params.require(:article).permit(:title, :text)
    end
end
