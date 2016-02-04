FactoryGirl.define do
	factory :user do
		sequence :email do |n|
			"dummyEmail#{n}@gmail.com"
		end
		password "secrectPassword"
		password_confirmation "secrectPassword"
	end

	factory :gram do 
		message "Hello"
		association :user
	end
end