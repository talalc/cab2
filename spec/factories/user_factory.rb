FactoryGirl.define do

  factory :user do
    email "john@john.com"
    password "password"
    password_confirmation "password"
    cc 0
    nick "john"
    admin false
  end

  factory :user_no_nick, class: User do
    email "john@john.com"
    password "password"
    password_confirmation "password"
    cc 0
    admin false
  end

  factory :admin, class: User do
    email "admin@admin.com"
    password "abcd1234"
    password_confirmation "abcd1234"
    cc 0
    nick "admin"
    admin true
  end

end