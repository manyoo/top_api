module TopApi
  module Tmall
    module Discount
      class Search < RestApi
        def initialize
          super
          @params[:method] = 'tmall.items.discount.search'
        end

        def get options
          request options do |body|
            resp = body['tmall_items_discount_search_response']
            yield resp
          end
        end
      end
    end

    module Selected
      class Search < RestApi
        def initialize
          super
          @params[:method] = 'tmall.selected.items.search'
        end

        def get options
          request options do |body|
            resp = body['tmall_selected_items_search_response']
            yield resp['item_list']['selected_item']
          end
        end
      end
    end

    module TeMai
      module Items
        class Search < RestApi
          def initialize
            super
            @params[:method] = 'tmall.temai.items.search'
          end

          def get options
            request options do |body|
              resp = body['tmall_temai_items_search_response']
              yield resp
            end
          end
        end
      end

      module Subcats
        class Search < RestApi
          def initialize
            super
            @params[:method] = 'tmall.temai.subcats.search'
          end

          def get options
            request options do |body|
              resp = body['tmall_temai_subcat_search_response']
              yield resp
            end
          end
        end
      end
    end
  end
end
