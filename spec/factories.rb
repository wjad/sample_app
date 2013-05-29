FactoryGirl.define do
  factory :user do
    # sequence(:name)  { |n| "Person #{n}" }
    # sequence(:email) { |n| "person_#{n}@example.com"}   

    #Lesson 7 @17:30
    name "Walid Jad"
    email "walid.jad@gmail.com"
    password "walid1"
    password_confirmation "walid1"

    # factory :admin do
    #   admin true
    # end
  end

  # factory :micropost do
  #   content "Lorem ipsum"
  #   user
  # end
end