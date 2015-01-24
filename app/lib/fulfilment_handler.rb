class FulfilmentHandler
  MESS = "SYSTEM ERROR: method missing"

  def get_printer_id; raise MESS; end
  def send_order(order); raise MESS; end

  def process_outstanding_orders
    sent_orders = Array.new
    received = Order.where(:status=>"received").all
    if (!received.blank?) then
      received.each do |order|
        if (!order.items.blank?) then
          order.items.each do |item|
            product = Product.find_by_id(item.product_id)
            puts "examining and ordered product"
            if (product.baseGood.printer_id == get_printer_id()) then
              sent_orders.push(send_order(order))
            end
          end
        end
      end
    end
    sent_orders
  end

end
