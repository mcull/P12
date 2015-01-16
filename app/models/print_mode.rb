class PrintMode
  include Dynamoid::Document

  table :name => :print_modes, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :printer_name
  field :customer_name
  field :active, :integer

end
