FactoryGirl.define do
  factory :comment do
    
  end
	factory :user do
		sequence :email do |n|
			"dummyEmail#{n}@gmail.com"
		end
		password "secrectPassword"
		password_confirmation "secrectPassword"
	end

	factory :gram do 
		message "Hello"
		picture { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'picture.png'))}
		
		association :user
	end
end