class PrintableGood
  include Dynamoid::Document

  table :name => :printable_goods, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :base_good_id
  field :size_id
  field :color_id
  field :design_constraint_id
  field :price_offset :float

end
