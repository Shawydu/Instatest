require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	describe "comments#create action" do
		it "should allow user to create comments on gram" do
			gram = FactoryGirl.create(:gram)
			user = FactoryGirl.create(:user)
			sign_in user
			post :create, gram_id: gram.id, comment: { message: "awesome gram"}
			expect(response).to redirect_to insta_path(gram)
			expect(gram.comments.last.message).to eq "awesome gram"
		end

		it "should require a user login to comment on a gram" do
			gram = FactoryGirl.create(:gram)
			post :create, gram_id: gram.id, comment: { message: "awesome gram"}
			expect(response).to redirect_to new_user_session_path
		end

		it "should return 404 if the gram is not found" do
			user = FactoryGirl.create(:user)
			sign_in user
			post :create, gram_id: 'fake_id', comment: { message: "awesome gram"}
			expect(response).to have_http_status(:not_found)
		end
	end 

end
