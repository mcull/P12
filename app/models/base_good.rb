Class BaseGood
  include Dynamoid::Document

  table :name => :base_goods, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :goods_category_id, :name, :description,:size_chart_uri, :price

  has_many :printable_goods
  has_many :sellable_goods
  belongs_to :goods_category

end
