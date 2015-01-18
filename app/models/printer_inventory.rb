class PrinterInventory
  include Dynamoid::Document

  table :name => :printer_inventory, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :printer_id
  field :base_good_id
  field :color_id
  field :size_id
  field :shelf_sku

  field :active, :integer


end
