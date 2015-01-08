class Size
  include Dynamoid::Document

  table :name => :sizes, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name

end
