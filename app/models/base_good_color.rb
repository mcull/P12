class BaseGoodColor
  include Dynamoid::Document

  table :name => :base_good_colors, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :base_good_id
  field :color_id

end
