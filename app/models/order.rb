class Order
  include Dynamoid::Document

  table :name => :orders, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :sales_channel_order_id, :status, :shipment_service_level_category, :ship_name, :ship_address_2, :ship_address_3, :city, :postal_code, :country, :raw_receipt
  field :purchase_date :datetime
  field :total, :float

  has_many :shipments
  has_many :order_items

end
