class DesignConstraint
  include Dynamoid::Document
  validates_presence_of :name
  validates_presence_of :description

  table :name => :design_constraints, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :description
  field :active, :integer

end
