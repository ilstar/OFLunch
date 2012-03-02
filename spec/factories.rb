# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    sequence(:email) do |i|
      "user#{i}@example.com"
    end
    password "itissecret"
  end

end
