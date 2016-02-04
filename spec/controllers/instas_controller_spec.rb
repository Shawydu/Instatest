require 'rails_helper'

RSpec.describe InstasController, type: :controller do
	describe "instas#index action" do
		it "should successfully show the page" do
			get :index
			expect(response).to have_http_status(:success)
		end
	end

	describe "instas#new action" do
	    it "should successfully show the new form" do
		    get :new
		    expect(response).to have_http_status(:success)
	    end
	end

	describe "instas#create action" do
		it "should successfully submit the new form" do
			post :create, gram: {message: 'Hello!'}
			expect(response).to redirect_to root_path

			gram = Gram.last
			expect(gram.message).to eq("Hello!")
		end
	end
end
