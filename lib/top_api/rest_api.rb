require 'digest/md5'
require 'net/http'
require 'uri'
require 'date'
require 'json'

class RestApi
  VERSION = '2.0'
  FORMAT = 'json'
  SIGN_METHOD = 'md5'

  SAND_BOX = 'http://gw.api.tbsandbox.com/router/rest?'
  PRODUCTION = 'http://gw.api.taobao.com/router/rest?'

  def initialize
    @base_url = PRODUCTION
    @base_url = SAND_BOX if Rails.configuration.is_sandbox
    @app_key = Rails.configuration.app_key
    @app_secret = Rails.configuration.app_secret
    @taobaoke_id = Rails.configuration.taobaoke_id

    @params = {:v => VERSION,
               :format => FORMAT,
               :sign_method => SIGN_METHOD
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
      yield(JSON.parse(res.body))
    end
  end
end