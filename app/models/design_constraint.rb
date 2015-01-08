class DesignConstraint
  include Dynamoid::Document

  table :name => :design_constraints, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name, :description

end
