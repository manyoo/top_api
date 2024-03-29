module TopApi
  module Taobaoke
    module Items
      TaobaokeItemFields = [:num_iid,
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
                            :volume]
      class Get < RestApi
        def initialize
          super
          @params[:method] = 'taobao.taobaoke.items.get'
          @params[:pid] = @taobaoke_id
          @params[:fields] = TaobaokeItemFields.join ','
        end

        def get options
          request options do |body|
            resp = body['taobaoke_items_get_response']
            nums = resp['total_results']
            items = resp['taobaoke_items']['taobaoke_item']
            yield(nums, items)
          end
        end
      end

      class Convert < RestApi
        def initialize
          super
          @params[:method] = 'taobao.taobaoke.items.convert'
          @params[:pid] = @taobaoke_id
          @params[:fields] = TaobaokeItemFields.join ','
        end

        def get options
          request options do |body|
            resp = body['taobaoke_items_convert_response']
            nums = resp['total_results']
            items = resp['taobaoke_items']['taobaoke_item']
            yield(nums, items)
          end
        end
      end

      module Coupon
        class Get < RestApi
          def initialize
            super
            @params[:method] = 'taobao.taobaoke.items.coupon.get'
            @params[:pid] = @taobaoke_id
            @params[:fields] = (TaobaokeItemFields | [:coupon_rate,
              :coupon_price, :coupon_start_time,
              :coupon_end_time, :shop_type]).join ','
          end

          def get options
            request options do |body|
              resp = body['taobaoke_items_coupon_get_response']
              nums = resp['total_results']
              items = resp['taobaoke_items']['taobaoke_item']
              yield(nums, items)
            end
          end
        end
      end

      module Relate
        class Get < RestApi
          def initialize
            super
            @params[:method] = 'taobao.taobaoke.items.relate.get'
            @params[:pid] = @taobaoke_id
            @params[:fields] = TaobaokeItemFields.join ','
          end

          def get options
            request options do |body|
              resp = body['taobaoke_items_relate_get_response']
              num = resp['total_results']
              items = resp['taobaoke_items']['taobaoke_item']
              yield(num, items)
            end
          end
        end
      end
    end

    module Report
      class Get < RestApi
        def initialize
          super
          @params[:method] = 'taobao.taobaoke.report.get'
          @params[:fields] = [:trade_parent_id,
                              :trade_id,
                              :real_pay_fee,
                              :commission_rate,
                              :commission,
                              :app_key,
                              :outer_code,
                              :create_time,
                              :pay_time,
                              :pay_price,
                              :num_iid,
                              :item_title,
                              :item_num,
                              :category_id,
                              :category_name,
                              :shop_title,
                              :seller_nick].join ','
        end

        def get options
          request options do |body|
            resp = body['taobaoke_report_get_response']
            num = resp['total_results']
            reports = resp['taobaoke_report']['taobaoke_report_members']['taobaoke_report_member']
            yield(num, reports)
          end
        end
      end
    end

    module Shops
      TaobaokeShopFields = [:seller_nick,
                            :user_id,
                            :shop_title,
                            :click_url,
                            :commission_rate,
                            :seller_credit,
                            :shop_type,
                            :total_auction,
                            :auction_count]
      class Get < RestApi
        def initialize
          super
          @params[:method] = 'taobao.taobaoke.shops.get'
          @params[:pid] = @taobaoke_id
          @params[:fields] = TaobaokeShopFields.join ','
        end

        def get options
          request options do |body|
            resp = body['taobaoke_shops_get_response']
            num = resp['total_results']
            shops = resp['taobaoke_shops']['taobaoke_shop']
            yield(num, shops)
          end
        end
      end

      class Convert < RestApi
        def initialize
          super
          @params[:method] = 'taobao.taobaoke.shops.convert'
          @params[:pid] = @taobaoke_id
          @params[:fields] = TaobaokeShopFields.join ','
        end

        def get options
          request options do |body|
            resp = body['taobaoke_shops_convert_response']
            shops = resp['taobaoke_shops']['taobaoke_shop']
            yield shops
          end
        end
      end

      module Relate
        class Get < RestApi
          def initialize
            super
            @params[:method] = 'taobao.taobaoke.shops.relate.get'
            @params[:pid] = @taobaoke_id
            @params[:fields] = TaobaokeShopFields.join ','
          end

          def get options
            request options do |body|
              resp = body['taobaoke_shops_relate_get_response']
              num = resp['total_results']
              shops = resp['taobaoke_shops']['taobaoke_shop']
              yield(num, shops)
            end
          end
        end
      end
    end
  end
end
