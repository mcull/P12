class Design
  include Dynamoid::Document

  table :name => :designs, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name, :description, :exemplar_media_uri, :design_owner_id

  belongs_to :design_owner
  has_many: :print_ready_art

end
