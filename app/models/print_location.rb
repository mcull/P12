class PrintLocation
  include Dynamoid::Document

  table :name => :print_locations, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :product_id
  field :print_ready_art_id
  field :active, :integer

end
