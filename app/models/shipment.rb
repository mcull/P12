class Shipment
  include Dynamoid::Document

  table :name => :shipments, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :order_id
  field :shipped_via
  field :sales_channel_confirmation_id
  field :raw_receipt
  
  field :ship_date :datetime
  field :cost, :float

  index :ship_date, :range => true

  belongs_to :order

end
