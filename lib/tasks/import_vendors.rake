# -*- encoding : utf-8 -*-
require 'csv'

desc "Import vendors from csv files"

task :import_vendors => :environment do
  Dir[Rails.root.join('data', 'vendors', '*.csv')].each do |file|
    vendor_name = File.basename(file, ".csv")
    puts "importing #{vendor_name}"
    vendor = Vendor.find_or_initialize_by_name(vendor_name)

    if vendor.new_record?
      vendor.save
    else
      puts "Skipped #{vendor_name} that is alreday in database"
      next
    end

    CSV.foreach(Rails.root.join('data', 'vendors', file)) do |row|
      next unless row[1].present?
      vendor.menu_items.create(:name => row[0], :price => row[1])
    end
    puts "imported #{vendor_name}"
  end
end
