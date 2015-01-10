class PrintableLocation
  include Dynamoid::Document
  validates_presence_of :name

  table :name => :printable_goods, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :active, :integer

  has_and_belongs_to_many :printable_good


end
