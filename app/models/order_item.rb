class OrderItem
  include Dynamoid::Document

  table :name => :order_items, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :order_id, :product_id,:sales_channel_order_item_id, :gift_message, :promotion, :raw_receipt
  field :quantity_ordered, :quantity_shipped :integer
  field :price, :shipping_price, :tax, :shipping_tax, :shipping_discount, :promotion_discount, :float

  belongs_to :order
  belongs_to :product

end
