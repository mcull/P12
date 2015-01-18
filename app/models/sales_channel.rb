class SalesChannel
  include Dynamoid::Document

  table :name => :sales_channels, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :account_id
  field :notes
  field :active, :integer

  validates_presence_of :name
  validates_presence_of :account_id



end
