class BaseGoodPrintMode
  include Dynamoid::Document

  table :name => :base_good_print_modes, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :base_good_id
  field :print_mode_id

end
