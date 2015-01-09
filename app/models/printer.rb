class Printer
  include Dynamoid::Document

  table :name => :printers, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :contact_email
  field :active, :integer

  has_many :printer_inventory

  validates_presence_of :name
  validates_format_of :contact_email, :with => /@/

end
