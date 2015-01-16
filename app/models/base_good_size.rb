class BaseGoodSize
  include Dynamoid::Document

  table :name => :base_good_sizes, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :base_good_id
  field :size_id

end
