class PostsController < ApplicationController
    def new
        if user_signed_in?
            @post = Post.new
        else
            redirect_to user_session_path
        end
    end
    
    def create
        @post = Post.new(params[:post].permit(:title, :text))
        @post.title = current_user.email
        @post.save
        redirect_to @post
    end
    
    def show
        @post = Post.find(params[:id])
    end
    
    def index
        @post = @posts = Post.paginate(:page => params[:page])
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        
        if @post.update(params[:post].permit(:title, :text))
            redirect_to @post
        else
            render 'edit'
        end
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        
        redirect_to posts_path
    end
    
    private
        def post_params
            params.require(:post).permit(:title, :text)
        end
end