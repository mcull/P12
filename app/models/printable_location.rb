class PrintableLocation
  include Dynamoid::Document
  validates_presence_of :name

  table :name => :printable_locations, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :active, :integer


end
