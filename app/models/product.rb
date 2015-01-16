class Product
  include Dynamoid::Document

  table :name => :products, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :printable_good_id
  field :sellable_good_id
  field :name

  field :num_of_additional_photos, :integer
  field :active, :integer

end
