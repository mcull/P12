class Printer
  include Dynamoid::Document

  table :name => :printers, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name, :contact_email

  has_many :printer_inventory

end
