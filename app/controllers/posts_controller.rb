class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

	def show
		@post = Post.find(params[:id])
	end

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post Created!"
			redirect_to current_user
		else
			flash.now[:danger] = 'Must be logged in to submit a post'
			redirect_to root_url
		end
	end



	private

		def post_params
			params.require(:post).permit(:content)
		end
end
