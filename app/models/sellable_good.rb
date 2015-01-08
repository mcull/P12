class SellableGood
  include Dynamoid::Document

  table :name => :sellable_goods, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :design_owner_id, :sales_channel_id
  field :markup

  belongs_to :base_good
  belongs_to :design_owner
  belongs_to :sales_channel

end
