class PrintableGood
  include Dynamoid::Document

  table :name => :printable_goods, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :sellable_good_id, :size_id, :color_id, :printer_inventory_id
  field :price_offset :float

  has_and_belongs_to_many :printable_locations
  belongs_to :base_good
  belongs_to :size
  belongs_to :color

end
