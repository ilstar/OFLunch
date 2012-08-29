class StatsController < ApplicationController

  set_tab :stats

  def popular_menus
    now = Time.current
    @menu_items = MenuItem.joins(:order_items)
                          .select("name, COUNT(menu_items.id) AS menu_item_count")
                          .group("menu_item_id")
                          .order("menu_item_count DESC")
                          .where(["order_items.created_at >= ? AND order_items.created_at < ?", now.beginning_of_week, now.end_of_week])
                          .limit(10)
  end
end
