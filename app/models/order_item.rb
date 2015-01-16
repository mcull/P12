class OrderItem
  include Dynamoid::Document

  table :name => :order_items, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :order_id
  field :product_id
  field :sales_channel_order_item_id
  field :gift_message
  field :promotion
  field :raw_receipt
  field :color_id
  field :size_id

  field :quantity_ordered, :integer
  field :quantity_shipped, :integer

  field :shipping_price, :float
  field :tax, :float
  field :shipping_tax, :float
  field :shipping_discount, :float
  field :promotion_discount, :float
  field :price, :float

  belongs_to :order
  belongs_to :product

end
