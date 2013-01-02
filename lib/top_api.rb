require "top_api/version"
require "top_api/config"
require "top_api/rest_api"
require "top_api/taobaoke"

module TopApi
  METHODS = {
    :taobaoke_items_get => Taobaoke::Items::Get,
    :taobaoke_coupon_get => Taobaoke::Coupon::Get,
    :taobaoke_relate_get => Taobaoke::Relate::Get,
    :taobaoke_report_get => Taobaoke::Report::Get
  }

  class << self
    def get_api(method)
      if METHODS.member? method
        METHODS[method].new
      end
    end
  end
end
