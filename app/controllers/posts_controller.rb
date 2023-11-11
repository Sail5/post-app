class PostsController < ApplicationController
    def index
        @posts = Post.all.order(created_at: :desc)
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)

        if @post.save
            redirect_to posts_path
        else
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    #def update
    #    @post = Post.find(params[:id])
    #   if @post.update(post_params)
    #      redirect_to posts_path
    #    else
    #      render :edit
    #    end
    #end

    #def destroy
    #    @post = Post.find(params[:id])
     #   @post.destroy
    #    redirect_to posts_path
        
    #end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        respond_to do |format|
          format.html { redirect_to posts_path }
          format.js   # 追加
        end
    end
    def image
        @post = Post.find(params[:id])
        send_data @post.image.download, type: @post.image.content_type, disposition: 'inline'
    end
    def update
        @post = Post.find(params[:id])
    
        # Check if a new image is being attached
        if params[:post][:new_image].present?
          @post.image.purge if @post.image.attached?  # Remove the old image
          @post.image.attach(params[:post][:new_image])  # Attach the new image
        end
    
        if @post.update(post_params)
          redirect_to posts_path
        else
          render :edit
        end
    end


    private

    def post_params
        params.require(:post).permit(:title, :content, :image)
    end
end

class Post < ApplicationRecord
    has_one_attached :image
  end
