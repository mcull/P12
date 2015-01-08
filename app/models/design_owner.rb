class DesignOwner
  include Dynamoid::Document

  table :name => :design_owners, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name, :contact_email

  has_many :designs
  has_many :sellable_goods

end
