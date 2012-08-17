# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
  ['送餐费', 'freight'],
  ['主食', ''],
  ['饮料', ''],
  ['凉菜', ''],
  ['热菜', ''],
  ['套餐', ''],
].each do |attr|
  Category.create! name: attr[0], identifier: attr[1]
end
