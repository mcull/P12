class UPCCode
  include Dynamoid::Document

  table :name => :upc_codes, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :code

  field :active, :integer

  def self.next
    UPCCode.where(:active=>1).first
  end
end
