class Product
  include Dynamoid::Document

  table :name => :products, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :printable_good_id, :sellable_good_id, :name, :print_mode, :photo_uri

  has_many :print_locations
  belongs_to :printer_inventory
  belongs_to :sellable_good

end
