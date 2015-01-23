class GoodsCategory
  include Dynamoid::Document
  validates_presence_of :name

  table :name => :goods_categories, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :amazon_feed_manager_class
  field :active, :integer

  has_many :base_goods

end
