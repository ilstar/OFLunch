# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    sequence(:email) do |i|
      "user#{i}@example.com"
    end
    password "itissecret"
    name "user"
  end

  factory :admin, parent: :user do
    role 'admin'
  end

  factory :vendor do
    sequence :name do |i|
      "vendor name #{i}"
    end
  end

  factory :category do
    name "category name"
  end

  factory :menu_item do
    association :vendor
    name 'menu_item name'
    price 4
  end

  factory :meal_time do
    after :build do |meal_time|
      meal_time.vendors << FactoryGirl.create(:vendor)
    end
  end

  factory :order do
    association :user
    association :meal_time
  end

  factory :order_item do
    association :order
    association :menu_item
    price 3
    amount 1
  end

  factory :balance do
    association :user
    amount 0
  end

  factory :balance_log do
    association :balance
    amount 100
  end

  factory :message do
    association :recipient, factory: :user
    association :entity, factory: :balance_log
  end

end
