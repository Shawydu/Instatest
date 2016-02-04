require 'rails_helper'

RSpec.describe InstasController, type: :controller do
	it "should deny a user remove the gram who did not create it" do
		gram = FactoryGirl.create(:gram)
		user = FactoryGirl.create(:user)
		sign_in user
		delete :destroy, id: gram.id
		expect(response).to have_http_status(:forbidden)
	end

	describe "instas#destroy action" do
		it "should deny unauthenticated users destroy a gram" do
			gram = FactoryGirl.create(:gram)
			delete :destroy, id: gram.id
			expect(response).to redirect_to new_user_session_path
		end

		it "should allow a user remove gram from database" do
			gram = FactoryGirl.create(:gram)
			sign_in gram.user
			delete :destroy, id: gram.id
			expect(response).to redirect_to root_path
			gram = Gram.find_by_id(gram.id)
			expect(gram).to eq nil
		end

		it "should return 404 error if the gram is not found" do
			user = FactoryGirl.create(:user)
			sign_in user
			delete :destroy, id: 'TACOCAT'
			expect(response).to have_http_status(:not_found)
		end
	end

	describe "instas#update action" do
		it "should deny a user update the gram who did not create it" do
			gram = FactoryGirl.create(:gram)
			user = FactoryGirl.create(:user)
			sign_in user
			patch :update, id: gram.id, gram: { message: 'wahoo'}
			expect(response).to have_http_status(:forbidden)
		end

		it "should deny unauthenticated users update a gram" do
			gram = FactoryGirl.create(:gram)
			patch :update, id: gram.id
			expect(response).to redirect_to new_user_session_path
		end
		
		it "should allow users to successfully update grams" do 
			gram = FactoryGirl.create(:gram, message: "Initial Value")
			sign_in gram.user
			patch :update, id: gram.id, gram: { message: 'Changed'}
			expect(response).to redirect_to root_path
			gram.reload
			expect(gram.message).to eq "Changed"
		end

		it "should return a 404 if the gram is not found" do
			user = FactoryGirl.create(:user)
			sign_in user
			patch :update, id: 'TACOCAT', gram: { message: "Changed"}
			expect(response).to have_http_status(:not_found)
		end

		it "should render the edit form with an status unprocessable_entity" do
			gram = FactoryGirl.create(:gram, message: "Initial Value")
			sign_in gram.user
			patch :update, id: gram.id, gram: { message: ''}
			expect(response).to have_http_status(:unprocessable_entity)
			gram.reload
			expect(gram.message).to eq("Initial Value")
		end
	end

	describe "instas#edit action" do
		it "should deny a user edit the gram who did not create it" do
			gram = FactoryGirl.create(:gram)
			user = FactoryGirl.create(:user)
			sign_in user
			get :edit, id: gram.id
			expect(response).to have_http_status(:forbidden)
		end

		it "should deny unauthenticated users edit a gram" do
			gram = FactoryGirl.create(:gram)
			get :edit, id: gram.id
			expect(response).to redirect_to new_user_session_path
		end
		
		it "should successfully show the edit form if the gram is found" do
			gram = FactoryGirl.create(:gram)
			sign_in gram.user
			get :edit, id: gram.id
			expect(response).to have_http_status(:success)
		end

		it "should return a 404 error if the gram is not found" do 
			user = FactoryGirl.create(:user)
			sign_in user
			get :edit, id: 'TACOCAT'
			expect(response).to have_http_status(:not_found)
		end
	end

	describe "instas#show action" do
		it "should successfully show the page if gram is found" do
			gram = FactoryGirl.create(:gram)
			get :show, id: gram.id
			expect(response).to have_http_status(:success)
		end

		it "should return a 404 error if the gram is not found" do
			get :show, id: 'TACOCAT'
			expect(response).to have_http_status(:not_found)
		end
	end

	describe "instas#index action" do
		it "should successfully show the page" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "instas#new action" do
		it "should require users to be signed in" do
			get :new
			expect(response).to redirect_to new_user_session_path
		end

	    it "should successfully show the new form" do
	    	user = FactoryGirl.create(:user)
			sign_in user
			
		    get :new
		    expect(response).to have_http_status(:success)
	    end
	end

	describe "instas#create action" do
		it "should require users to be signed in" do
			post :create, gram: { message: 'Hello!'}
			expect(response).to redirect_to new_user_session_path
		end

		it "should successfully submit the new form" do
			user = FactoryGirl.create(:user)
			sign_in user

			post :create, gram: { message: 'Hello!'}
			expect(response).to redirect_to root_path

			gram = Gram.last
			expect(gram.message).to eq("Hello!")
			expect(gram.user).to eq(user)
		end

		it "should properly deal with validation errors" do
			user = FactoryGirl.create(:user)
			sign_in user
			
			post :create, gram: { message: ''}
			expect(response).to have_http_status(:unprocessable_entity)
			expect(Gram.count).to eq 0
		end
	end
end
