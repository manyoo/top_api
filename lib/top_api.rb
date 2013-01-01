require "top_api/version"

module TopApi
  autoload :Config, "top_api/config"
  autoload :RestApi, "top_api/rest_api"
  autoload :Taobaoke, "top_api/taobaoke"

  class << self
    METHODS = {
      :taobaoke_items_get => Taobaoke::Items::Get
    }

    def get_api(method)
      if METHODS.member? method
        METHODS[method].new
      end
    end
  end
end
