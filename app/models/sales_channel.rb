class SalesChannel
  include Dynamoid::Document

  table :name => :sales_channels, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name, :account_id, :notes

  has_many :sellable_goods

end
