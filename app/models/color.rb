require 'securerandom'

class Color
  include Dynamoid::Document
  include Comparable
  validates_presence_of :name

  table :name => :colors, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :amazon_color_map
  field :short_id

  field :active, :integer

  after_initialize :defaults

  def defaults
    if self.short_id.blank? then
      self.short_id = SecureRandom.hex(5)
    end
  end


  def <=> other
    self.name <=> other.name
  end

end
