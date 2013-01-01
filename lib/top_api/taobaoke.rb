module TopApi
  module Taobaoke
    module Items
      class Get < RestApi
        def initialize
          super
          @params[:method] = 'taobao.taobaoke.items.get'
          @params[:pid] = @taobaoke_id
          @params[:fields] = [:num_iid,
                              :nick,
                              :title,
                              :price,
                              :item_location,
                              :seller_credit_score,
                              :click_url,
                              :shop_click_url,
                              :pic_url,
                              :commission_rate,
                              :commission,
                              :commission_num,
                              :commission_volume,
                              :volume].join ','
        end

        def get(options)
          request options do |body|
            resp = body[:taobaoke_items_get_response]
            nums = resp[:total_results]
            items = resp[:taobaoke_items][:taobaoke_item]
            yield(nums, items)
          end
        end
      end
    end
  end
end
