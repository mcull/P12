class Size
  include Dynamoid::Document

  table :name => :sizes, :key => :id, :read_capacity => 5, :write_capacity => 5

  field :name
  field :sort_order, :integer
  field :active, :integer

  validates_presence_of :name

end
