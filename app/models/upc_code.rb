class UPCCode
  include Dynamoid::Document

  table :name => :upc_codes, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :code
  field :product_id
  field :color_id
  field :size_id

  field :active, :integer

  def self.next
    code = UPCCode.where(:active=>1).all.first
    code.active = 0
    code.save
    code
    #code = UPCCode.new
    #code.code = SecureRandom.uuid
    #code.active = 1
    #code
  end
end
