require "top_api/version"
require "top_api/config"
require "top_api/rest_api"
require "top_api/taobaoke"
require "top_api/tmall"


module TopApi
  METHODS = {
    :taobaoke_items_get => Taobaoke::Items::Get,
    :taobaoke_items_convert => Taobaoke::Items::Convert,
    :taobaoke_items_coupon_get => Taobaoke::Items::Coupon::Get,
    :taobaoke_items_relate_get => Taobaoke::Items::Relate::Get,
    :taobaoke_report_get => Taobaoke::Report::Get,
    :taobaoke_shops_get => Taobaoke::Shops::Get,
    :taobaoke_shops_convert => Taobaoke::Shops::Convert,
    :taobaoke_shops_relate_get => Taobaoke::Shops::Relate::Get,

    :tmall_discount_search => Tmall::Discount::Search,
    :tmall_selected_search => Tmall::Selected::Search,
    :tmall_temai_items_search => Tmall::TeMai::Items::Search,
    :tmall_temai_subcats_search => Tmall::TeMai::Subcats::Search
  }

  class << self
    def get_api method
      if METHODS.member? method
        METHODS[method].new
      end
    end

    def top_call method, options, &blocks
      api = get_api method
      api.get options, &blocks
    end
  end
end
