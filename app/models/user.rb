# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  devise :database_authenticatable, #:registerable,
    :rememberable, :trackable, :validatable

  has_many :orders
  has_many :unread_messages, foreign_key: 'recipient_id', class_name: 'Message', conditions: {read: false}, order: 'id DESC'
  has_one :balance, :dependent => :destroy

  scope :admin, where(role: 'admin')

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  validates_presence_of :name

  after_create :create_balance_for_user

  def identifier
    self.name.presence || self.email
  end

  def admin?
    self.role == "admin"
  end

  def can_access_by?(user)
    user == self || user.admin?
  end

  def account_balance
    self.balance.amount
  end

  def today_order_items
    today_order = MealTime.today.orders.find_by_user_id(self.id)

    return [] if today_order.nil?

    today_order.order_items.includes(:menu_item).map do |order_item|
      {
        id: order_item.menu_item_id,
        name: order_item.menu_item.name,
        count: order_item.amount,
        price: order_item.menu_item.price,
      }
    end
  end

  protected

  def create_balance_for_user
    self.create_balance(amount: 0)
  end

end
