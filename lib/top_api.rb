require "top_api/version"
require "top_api/rest_api"
require "top_api/taobaoke"

if defined?(Rails)
  module TopApi
    METHODS = {
      :taobaoke_items_get => Taobaoke::Items::Get
    }

    class << self
      def get_api(method)
        if METHODS.member? method
          METHODS[method].new
        end
      end
    end

    class TopApiRailtie < Rails::Railtie
    end
  end
end
