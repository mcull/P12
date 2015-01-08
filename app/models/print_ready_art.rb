class PrintReadyArt
  include Dynamoid::Document

  table :name => :print_ready_art, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :media_uri, :design_id, :design_constraint_id,

  belongs_to :design
  belongs_to :design_constraint

end
