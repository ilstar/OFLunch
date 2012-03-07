# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  devise :database_authenticatable, #:registerable,
         :rememberable, :trackable, :validatable

  has_many :orders
  has_one :balance, :dependent => :destroy

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name


  def admin?
    self.role == "admin"
  end
end
