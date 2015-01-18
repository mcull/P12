class ProductPrintLocation
  include Dynamoid::Document

  table :name => :printable_good_locations, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :product_id
  field :printable_location_id
  field :print_ready_art_id

end
