class PrinterInventory
  include Dynamoid::Document

  table :name => :printer_inventory, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :printer_id, :printable_good_id, :shelf_sku

  belongs_to :printer
  belongs_to :printable_good

end
