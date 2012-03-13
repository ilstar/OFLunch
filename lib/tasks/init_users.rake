# -*- encoding : utf-8 -*-
desc "generate users"

task :init_users => :environment do
  pwd = "openfeint"
  User.create! name: "Andy Yao", email: "andy.yao@gree.co.jp", password: pwd
  User.create! name: "Kevin Xu", email: "kevin.xu@gree.co.jp", password: pwd
  User.create! name: "Fred Liang", email: "fred.liang@gree.co.jp", password: pwd
  User.create! name: "Richard Huang", email: "richard.huang@gree.co.jp", password: pwd
  User.create! name: "Jason Lai", email: "jason.lai@gree.co.jp", password: pwd
  User.create! name: "Jian Fu", email: "jian.fu@gree.co.jp", password: pwd
  User.create! name: "Bo Fu", email: "bo.fu@gree.co.jp", password: pwd
  User.create! name: "Vincent Xie", email: "vincent.xie@gree.co.jp", password: pwd
  User.create! name: "Lay Zhu", email: "lay.zhu@gree.co.jp", password: pwd, role: 'admin'
  User.create! name: "Xingkui Wang", email: "xingkui.wang@gree.co.jp", password: pwd
  User.create! name: "Yue Tian", email: "yue.tian@gree.co.jp", password: pwd
  User.create! name: "Tiancong Pang", email: "tiancong.pang@gree.co.jp", password: pwd
  User.create! name: "He Tian", email: "he.tian@gree.co.jp", password: pwd
  User.create! name: "Ray Huang", email: "ray.huang@gree.co.jp", password: pwd
  User.create! name: "Chang Cheng", email: "chang.cheng@gree.co.jp", password: pwd
  User.create! name: "Rong Yang", email: "rong.yang@gree.co.jp", password: pwd
  User.create! name: "Yu Hu", email: "yu.hu@gree.co.jp", password: pwd

  User.all.each do |user|
    user.balance = Balance.new(:amount => 0) if user.balance.nil?
  end
end
