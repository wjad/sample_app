require 'spec_helper'

describe "User Pages" do
	subject { page }

		
		describe "index" do    
		    before do
		      sign_in FactoryGirl.create(:user)
		      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
		      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
		      visit users_path
		    end

   		 	it { should have_selector('title', text: 'All users') }
   		end
		describe "Profile Page" do
				#**********************************************************
			  #Lesson 7 @14.30
			  let(:user) {FactoryGirl.create(:user)}			
			  before { visit user_path(user)}#in this line, user path param will be converted to ID
			  it { should have_selector('h1', text: user.name )}
			  it { should have_selector('title', text: user.name )}
		end

		describe "signing page" do

			before { visit signup_path }
			it { should have_selector('h1', text: 'Sign Up') }
			it { should have_selector('title', text: full_title('Sign Up'))}

		end
		describe "signup" do
			before { visit signup_path }
			let(:submit) {"Create my account"} #This line of code is to avoid repeation at click_button. so we created a command submit.


			describe "with invalid information" do
				it "should not create user" do
					expect { click_button submit }.not_to change(User, :count) # This one line of code replaces the following lines
					# old_count=User.count
					# click_button submit
					# new_count = User.count
					# new_count.should == old_count
				end

				describe "after submission" do
					before { click_button submit }
					it {should have_selector('title', text: 'Sign Up')}
					it {should have_content('error')}

				end

			end 

			describe "with valid information" do
				before do
					fill_in "Name", 		with: "Example User"
					fill_in "Email", 		with: "user@example.com"
					fill_in "Password", 	with: "foobar"
					fill_in "Confirmation", with: "foobar"
				end
				it "should create a new user" do
					expect { click_button submit }.to change(User, :count).by(1) # This one line of code replaces the following lines

					# old_count = User.count
					# click_button submit
					# new_count = User.count
					# new_count.should == old_count +1

				end
				describe "after saving the user" do 
					before {click_button submit}
					let(:user) { User.find_by_email("user@example.com")}
					it {should have_selector('title', text: user.name)}
					it { should have_link('Sign out') }
				end


			end
		end

		describe "edit" do
		let(:user) { FactoryGirl.create(:user)}
		before do
			sign_in user
		  	visit edit_user_path(user) 
		end
			describe "page" do
				it { should have_selector('h1', text: "Update your profile")}
				it { should have_selector('title', text: "Edit user")}
				it { should have_link('change', href: 'http://gravatar.com/emails')}
			end

			describe "with invalid information" do
	      		before { click_button "Save changes" }
	      		it { should have_content('error') }
	    	end
		    describe "with valid information" do
		      	let(:new_name)  { "New Name" }
		      	let(:new_email) { "new@example.com" }
		      	before do
		        fill_in "Name",             with: new_name
		        fill_in "Email",            with: new_email
		        fill_in "Password",         with: user.password
		        fill_in "Confirm Password", with: user.password
		        click_button "Save changes"
		      end

		       it { should have_selector('title', text: new_name) }
		       it { should have_selector('div.alert.alert-success') }
		       it { should have_link('Sign out', href: signout_path) }
		       specify { user.reload.name.should  == new_name }
		       specify { user.reload.email.should == new_email }
		    end


	end
end
