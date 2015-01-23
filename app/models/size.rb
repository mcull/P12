require 'securerandom'

class Size
  include Dynamoid::Document

  table :name => :sizes, :key => :id, :read_capacity => 5, :write_capacity => 5

  field :name
  field :short_id
  field :sort_order, :integer
  field :additional_price, :float
  field :active, :integer

  validates_presence_of :name

  after_initialize :defaults

  def defaults
    if self.short_id.blank? then
      self.short_id = SecureRandom.hex(5)
    end
  end



end
