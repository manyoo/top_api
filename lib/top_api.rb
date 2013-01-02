require "top_api/version"
require "top_api/config"
require "top_api/rest_api"
require "top_api/taobaoke"

module TopApi
  METHODS = {
    :taobaoke_items_get => Taobaoke::Items::Get,
    :taobaoke_items_coupon_get => Taobaoke::Items::Coupon::Get,
    :taobaoke_items_relate_get => Taobaoke::Items::Relate::Get,
    :taobaoke_report_get => Taobaoke::Report::Get,
    :taobaoke_shops_get => Taobaoke::Shops::Get,
    :taobaoke_shops_relate_get => Taobaoke::Shops::Relate::Get
  }

  class << self
    def get_api(method)
      if METHODS.member? method
        METHODS[method].new
      end
    end
  end
end
