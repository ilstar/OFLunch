# -*- encoding : utf-8 -*-
desc "Init vendors and menu items"

task :init_vendors => :environment do
  v = Vendor.create name: '拿拿家', address: '海淀区成府路23号五道口宾馆北侧', phone_number: '010-8237 0500'
  menu_items = [
    %w{14 拿拿家包饭},
    %w{10 蔬菜紫菜包饭},
    %w{16 鸡肉紫菜包饭},
    %w{18 牛肉紫菜包饭},
    %w{18 金枪鱼紫菜包饭},
    %w{20 金枪鱼沙拉紫菜包饭},
    %w{15 奶酪紫菜包饭},
    %w{22 忠武紫菜包饭},
    %w{18 泡菜炒饭},
    %w{21 金枪鱼炒饭},
    %w{21 培根泡菜炒饭},
    %w{22 海鲜炒饭},
    %w{21 培根炒饭},
    %w{20 虾仁炒饭},
    %w{20 蛋包饭},
    %w{20 牛肉炒饭},
    %w{26 牛肉饭},
    %w{22 泡菜五花肉饭},
    %w{24 猪肉饭},
    %w{26 鱿鱼饭},
    %w{22 鸡肉饭},
    %w{23 鸡肉块饭},
    %w{22 鸡肉咖喱饭},
    %w{22 杂菜饭},
    %w{18 大酱汤},
    %w{20 泡菜饭},
    %w{20 部队汤},
    %w{20 辣豆腐汤},
    %w{23 辣牛肉汤},
    %w{23 金枪鱼泡菜汤},
    %w{23 秋刀鱼泡菜汤},
    %w{23 明太鱼汤},
    %w{15 辛拉面},
    %w{17 泡菜拉面},
    %w{17 米片拉面},
    %w{18 饺子拉面},
    %w{20 海鲜拉面},
    %w{20 奶酪拉面},
    %w{16 蔬菜拌饭},
    %w{18 大酱拌饭},
    %w{23 金枪鱼拌饭},
    %w{23 培根拌饭},
    %w{23 鸡肉拌饭},
    %w{22 猪肉拌饭},
    %w{24 牛肉拌饭},
    %w{24 鱿鱼拌饭},
    %w{18 冷面},
    %w{18 弹面},
    %w{18 拌面},
    %w{22 泡菜饺子面片汤},
    %w{24 海鲜面片汤},
    %w{25 海鲜汤面},
    %w{20 饺子米片汤},
    %w{18 炸酱面},
    %w{14 蔬菜沙拉},
    %w{15 土豆泥沙拉},
    %w{8 拌干豆腐丝},
    %w{18 鸡肉沙拉},
    %w{20 金枪鱼沙拉},
    %w{15 拌牛肉丝},
    %w{16 炒米条},
    %w{18 鸡蛋卷},
    %w{20 炒拉面},
    %w{20 煎鱿鱼},
    %w{25 炒乌冬面},
    %w{40 糖醋肉},
  ]

  menu_items.each do |arr|
    v.menu_items.create price: arr[0], name: arr[1]
  end
  v = Vendor.create name: '麦当劳', address: '海淀区成府路23号五道口宾馆北侧', phone_number: '010-8237 0500'
  menu_items.each do |arr|
    v.menu_items.create price: arr[0], name: arr[1]
  end

  v = Vendor.create name: '肯德基', address: '海淀区成府路23号五道口宾馆北侧', phone_number: '010-8237 0500'
  menu_items.each do |arr|
    v.menu_items.create price: arr[0], name: arr[1]
  end
end
