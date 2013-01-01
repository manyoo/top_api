module TopApi
  module Config
    class << self
      attr_accessor :settings
      def init_top_api options
        @settings = options
      end
    end
  end
end