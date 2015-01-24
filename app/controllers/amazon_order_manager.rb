require 'peddler'
require 'rubygems'
require 'json'

class AmazonOrderManager

  def self.get_client
    MWS.orders(
      marketplace_id:        ENV['MWS_MARKETPLACE_ID'],
      merchant_id:           ENV['MWS_MERCHANT_ID'],
      aws_access_key_id:     ENV['MWS_AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['MWS_AWS_SECRET_KEY']
    )
  end

  def self.get_new_orders
    get_client.list_orders({
      :created_after  => '2015-01-01',
      :order_status   =>  [:Unshipped,:PartiallyShipped]
      })
  end

  def self.get_order_items(order_id)
    get_client.list_order_items(order_id)
  end

  def self.process_new_orders
    orders = get_new_orders.parse
    total_orders_added = 0
    total_orders_examined = 0
    orders["Orders"].each do |key, order|
      total_orders_examined += 1
      amazon_order_id = order["AmazonOrderId"]
      existing_order = Order.where(:sales_channel_order_id => amazon_order_id).first

      if (existing_order.blank?) then
        new_order = Order.new({
          :sales_channel_order_id           =>  amazon_order_id,
          :status                           =>  "received",
          :shipment_service_level_category  =>  order["ShipmentServiceLevelCategory"],
          :ship_name                        =>  order["ShippingAddress"]["Name"],
          :ship_address_1                   =>  order["ShippingAddress"]["AddressLine1"],
          :ship_address_2                   =>  order["ShippingAddress"]["AddressLine2"],
          :city                             =>  order["ShippingAddress"]["City"],
          :state                            =>  order["ShippingAddress"]["StateOrRegion"],
          :postal_code                      =>  order["ShippingAddress"]["PostalCode"],
          :country                          =>  order["ShippingAddress"]["CountryCode"],
          :raw_receipt                      =>  order.to_json,
          :purchase_date                    =>  order["PurchaseDate"].to_datetime,
          :total                            =>  order["OrderTotal"]["Amount"].to_f
          })
          if (new_order.save) then
            total_orders_added += 1
            order_items = get_order_items(amazon_order_id).parse
            p order_items
            order_items["OrderItems"].each do |key, item|
              product_sku = item["SellerSKU"]
              bits = product_sku.split("_")
              product_short_id = bits[0]
              color_short_id = bits[1][2..-1]
              size_short_id = bits[2][2..-1]
              product = Product.find_by_short_id(product_short_id)
              color = Color.find_by_short_id(color_short_id)
              size = Size.find_by_short_id(size_short_id)
              new_order_item = OrderItem.new({
                :order_id                     => new_order.id,
                :product_id                   => product.id,
                :sales_channel_order_item_id  => item["OrderItemId"],
                :promotion                    => item["Promotion"],
                :raw_receipt                  => item.to_json,
                :color_id                     => color.id,
                :size_id                      => size.id,
                :quantity_ordered             => item["QuantityOrdered"],
                :quantity_shipped             => 0,
                :shipping_price               => item["ShippingPrice"]["Amount"],
                :tax                          => item["ItemTax"]["Amount"],
                :shipping_tax                 => item["ShippingTax"]["Amount"],
                :shipping_discount            => item["ShippingDiscount"]["Amount"],
                :promotion_discount           => item["PromotionDiscount"]["Amount"],
                :price                        => item["ItemPrice"]["Amount"]
                })
                new_order_item.save
              end
            end
      end
    end
    '{"OrdersExamined":' + total_orders_examined.to_s + ',"OrdersAdded":' + total_orders_added.to_s + '}'

  end

  def update_order(order_id, status)

  end

end
