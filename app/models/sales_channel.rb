class SalesChannel
  include Dynamoid::Document

  table :name => :sales_channels, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :account_id
  field :notes

  has_many :sellable_goods

end
