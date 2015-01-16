class BaseGoodPrintLocation
  include Dynamoid::Document

  table :name => :base_good_print_locations, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :base_good_id
  field :printable_location_id

end
