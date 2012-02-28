# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create users
pwd = "openfeint"
User.create! name: "Andy Yao", email: "andy.yao@gree.co.jp", password: pwd
User.create! name: "Kevin Xu", email: "kevin.xu@gree.co.jp", password: pwd
User.create! name: "Fred Liang", email: "fred.liang@gree.co.jp", password: pwd
User.create! name: "Richard Huang", email: "richard.huang@gree.co.jp", password: pwd
User.create! name: "Jason Lai", email: "jason.lai@gree.co.jp", password: pwd
User.create! name: "Jian Fu", email: "jian.fu@gree.co.jp", password: pwd
User.create! name: "Bo Fu", email: "bo.fu@gree.co.jp", password: pwd
User.create! name: "Vincent Xie", email: "vincent.xie@gree.co.jp", password: pwd
User.create! name: "lay.zhu", email: "lay.zhu@gree.co.jp", password: pwd
User.create! name: "Xingkui Wang", email: "xingkui.wang@gree.co.jp", password: pwd
User.create! name: "Yue Tian", email: "yue.tian@gree.co.jp", password: pwd
User.create! name: "Tiancong Pang", email: "tiancong.pang@gree.co.jp", password: pwd
User.create! name: "He Tian", email: "he.tian@gree.co.jp", password: pwd
User.create! name: "Ray Huang", email: "ray.huang@gree.co.jp", password: pwd
User.create! name: "Chang Cheng", email: "chang.cheng@gree.co.jp", password: pwd
User.create! name: "Rong Yang", email: "rong.yang@gree.co.jp", password: pwd
User.create! name: "Yu Hu", email: "yu.hu@gree.co.jp", password: pwd

v = Vendor.create name: '拿拿家', address: '海淀区成府路23号五道口宾馆北侧', phone_number: '010-8237 0500'
menu_items = [
  %w{1 14 拿拿家包饭},
  %w{2 10 蔬菜紫菜包饭},
  %w{3 16 鸡肉紫菜包饭},
  %w{4 18 牛肉紫菜包饭},
  %w{5 18 金枪鱼紫菜包饭},
  %w{6 20 金枪鱼沙拉紫菜包饭},
  %w{7 15 奶酪紫菜包饭},
  %w{8 22 忠武紫菜包饭},
  %w{9 18 泡菜炒饭},
  %w{10 21 金枪鱼炒饭},
  %w{11 21 培根泡菜炒饭},
  %w{12 22 海鲜炒饭},
  %w{13 21 培根炒饭},
  %w{14 20 虾仁炒饭},
  %w{15 20 蛋包饭},
  %w{16 20 牛肉炒饭},
  %w{17 26 牛肉饭},
  %w{18 22 泡菜五花肉饭},
  %w{19 24 猪肉饭},
  %w{20 26 鱿鱼饭},
  %w{21 22 鸡肉饭},
  %w{22 23 鸡肉块饭},
  %w{23 22 鸡肉咖喱饭},
  %w{24 22 杂菜饭},
  %w{25 18 大酱汤},
  %w{26 20 泡菜饭},
  %w{27 20 部队汤},
  %w{28 20 辣豆腐汤},
  %w{29 23 辣牛肉汤},
  %w{30 23 金枪鱼泡菜汤},
  %w{31 23 秋刀鱼泡菜汤},
  %w{32 23 明太鱼汤},
  %w{33 15 辛拉面},
  %w{34 17 泡菜拉面},
  %w{35 17 米片拉面},
  %w{36 18 饺子拉面},
  %w{37 20 海鲜拉面},
  %w{38 20 奶酪拉面},
  %w{39 16 蔬菜拌饭},
  %w{40 18 大酱拌饭},
  %w{41 23 金枪鱼拌饭},
  %w{42 23 培根拌饭},
  %w{43 23 鸡肉拌饭},
  %w{44 22 猪肉拌饭},
  %w{45 24 牛肉拌饭},
  %w{46 24 鱿鱼拌饭},
  %w{47 18 冷面},
  %w{48 18 弹面},
  %w{49 18 拌面},
  %w{50 22 泡菜饺子面片汤},
  %w{51 24 海鲜面片汤},
  %w{52 25 海鲜汤面},
  %w{53 20 饺子米片汤},
  %w{54 18 炸酱面},
  %w{55 14 蔬菜沙拉},
  %w{56 15 土豆泥沙拉},
  %w{57 8 拌干豆腐丝},
  %w{58 18 鸡肉沙拉},
  %w{59 20 金枪鱼沙拉},
  %w{60 15 拌牛肉丝},
  %w{61 16 炒米条},
  %w{62 18 鸡蛋卷},
  %w{63 20 炒拉面},
  %w{64 20 煎鱿鱼},
  %w{65 25 炒乌冬面},
  %w{66 40 糖醋肉},
]
menu_items.each do |arr|
  v.menu_items.create serial_num: arr[0], price: arr[1], name: arr[2]
end

v = Vendor.create name: '麦当劳', address: '海淀区成府路23号五道口宾馆北侧', phone_number: '010-8237 0500'
menu_items.each do |arr|
  v.menu_items.create serial_num: arr[0], price: arr[1], name: arr[2]
end

v = Vendor.create name: '肯德基', address: '海淀区成府路23号五道口宾馆北侧', phone_number: '010-8237 0500'
menu_items.each do |arr|
  v.menu_items.create serial_num: arr[0], price: arr[1], name: arr[2]
end
