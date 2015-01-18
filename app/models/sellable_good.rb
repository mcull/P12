class SellableGood
  include Dynamoid::Document

  table :name => :sellable_goods, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :base_good_id
  field :design_owner_id
  field :sales_channel_id

  field :markup, :float

  field :active, :integer

end
