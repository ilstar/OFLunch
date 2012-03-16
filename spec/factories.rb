# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    sequence(:email) do |i|
      "user#{i}@example.com"
    end
    password "itissecret"
  end

  factory :vendor do
    sequence :name do |i|
      "vendor name #{i}"
    end
  end

  factory :meal_time do
    after_build do |meal_time|
      meal_time.vendors << Factory(:vendor)
    end
  end

  factory :order do
    association :user
    association :meal_time
  end

  factory :balance do
    amount 0
  end

  factory :balance_log do
    association :balance
    amount 100
  end

end
