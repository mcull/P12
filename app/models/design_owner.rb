class DesignOwner
  include Dynamoid::Document

  table :name => :design_owners, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :contact_email

  field :active, :integer

end
