class AddColumnDeletedAtToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :deleted_at, :datetime

  end
end
