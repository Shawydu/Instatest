class CommentsController < ApplicationController
	# def create
	# 	@comment = current_user.comments.create(comment_params)
	# 	redirect_to root_path
	# end

	private

	def comment_params
		params.require(:comment).permit(:message)
	end
end
