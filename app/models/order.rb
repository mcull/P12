class Order
  include Dynamoid::Document

  table :name => :orders, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :sales_channel_order_id
  field :sales_channel_status
  field :status
  field :shipment_service_level_category
  field :ship_name
  field :ship_address_1
  field :ship_address_2
  field :ship_address_3
  field :city
  field :state
  field :postal_code
  field :country
  field :raw_receipt

  field :purchase_date, :datetime
  field :total, :float

  def items
    if (@items.blank?) then
      @items = OrderItem.where(:order_id => self.id).all
    end
    @items
  end

end
