class Color
  include Dynamoid::Document
  include Comparable
  validates_presence_of :name

  table :name => :colors, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :active, :integer



  def <=> other
    self.name <=> other.name
  end

end
