class Color
  include Dynamoid::Document
  include Comparable

  table :name => :colors, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name

  def <=> other
    self.name <=> other.name
  end

end
