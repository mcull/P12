class Color
  include Dynamoid::Document

  table :name => :colors, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name

end
