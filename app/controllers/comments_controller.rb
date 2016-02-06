class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@gram = Gram.find_by_id(params[:insta_id])
		return render_not_found if @gram.blank?

		@gram.comments.create(comment_params.merge(user: current_user))
		redirect_to root_path
	end

	private

	def render_not_found
		render text: "Not Found :((", status: :not_found	
	end

	def comment_params
		params.require(:comment).permit(:message)
	end
end
