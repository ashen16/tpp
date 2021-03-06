  class PostsController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]

	def index
		if params[:tag]
    	@posts = policy_scope(Post).order('created_at DESC').tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 6)
    	@post = @posts.first
  	else
    	@posts = policy_scope(Post).order('created_at DESC').paginate(:page => params[:page], :per_page => 6)
    	@post = @posts.first
  	end
	end

	def show
		@post = Post.find(params[:id])

		if request.path != post_path(@post)
	    redirect_to @post, status: :moved_permanently
	  end
	end

	def new
		@post = Post.new
	end

	def edit
		@post = Post.find(params[:id])
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			if params[:post][:image].present?
				render :crop
			else
				redirect_to posts_path, notice: 'Post was successfully added.'
			end
		else
			render action: 'new'
		end
	end

	def update
		@post = Post.find(params[:id])

		if @post.update_attributes(post_params)
			if params[:post][:image].present?
				render :crop
			else
				redirect_to posts_path, notice: 'Post was successfully updated.'
			end
		else
			render action: 'new'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:title, :body, :image, :remote_image_url, :published, :tag_list, :crop_x, :crop_y, :crop_w, :crop_h)
	end
end
