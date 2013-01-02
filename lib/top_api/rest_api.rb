require 'digest/md5'
require 'net/http'
require 'uri'
require 'date'
require 'json'

module TopApi
  class RestApi
    VERSION = '2.0'
    FORMAT = 'json'
    SIGN_METHOD = 'md5'

    SAND_BOX = 'http://gw.api.tbsandbox.com/router/rest?'
    PRODUCTION = 'http://gw.api.taobao.com/router/rest?'

    def initialize
      @base_url = PRODUCTION
      @base_url = SAND_BOX if Config.settings[:is_sandbox]
      @app_key = Config.settings[:app_key]
      @app_secret = Config.settings[:app_secret]
      @taobaoke_id = Config.settings[:taobaoke_id]

      @params = {:v => VERSION,
                 :format => FORMAT,
                 :sign_method => SIGN_METHOD,
                 :app_key => @app_key
                }
    end

    def sign
      param_str = @app_secret + @params.sort.flatten.join + @app_secret
      @params[:sign] = Digest::MD5.hexdigest(param_str).upcase
    end

    def build_url
      keyvalues = []
      @params.each {|k, v| keyvalues.push "#{k}=#{URI.escape v}" }
      @base_url + keyvalues.join('&')
    end

    def request(options)
      @params.merge! options
      @params[:timestamp] = DateTime.now.strftime('%F %T')
      sign
      url = URI.parse build_url
      res = Net::HTTP.get_response(url)
      if res.code == '200'
        js = JSON.parse res.body
        if js.member? 'error_response'
          msg = js['error_response']['msg']
          raise ArgumentError, msg
        else
          yield(js)
        end
      end
    end
  end
end
