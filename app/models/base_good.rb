class BaseGood
  include Dynamoid::Document

  table :name => :base_goods, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :goods_category_id
  field :name
  field :description
  field :size_chart_uri
  field :amazon_node_id

  field :bullet1
  field :bullet2
  field :bullet3
  field :bullet4
  field :bullet5

  field :price, :float
  field :active, :integer

  def goodsCategory
    if @goodsCategory.blank? then
      @goodsCategory = GoodsCategory.find_by_id(self.goods_category_id)
    end
    @goodsCategory
  end

  def printableLocationConfig
    if @printLocation.blank? then
      @printLocation = BaseGoodPrintLocation.where(:base_good_id => self.id).first
    end
    @printLocation
  end

  def uncachePrintLocation
    @printLocation = nil
  end

  def colors
    if @colors.blank? then
      @colors = Array.new
      bgColors = BaseGoodColor.where(:base_good_id => self.id).all
      if (!bgColors.blank?) then
        bgColors.each do |bgc|
          @colors.push(Color.find_by_id(bgc.color_id))
        end
        @colors.sort_by! { |a| [ a.name ] }
      end
    end
    @colors
  end

  def uncacheColors
    @colors = nil
  end

  def sizes
    if @sizes.blank? then
      @sizes = Array.new
      bgSizes = BaseGoodSize.where(:base_good_id => self.id).all
      if (!bgSizes.blank?) then
        bgSizes.each do |bgs|
          @sizes.push(Size.find_by_id(bgs.size_id))
        end
        @sizes.sort_by! { |a| [ a.sort_order, a.name ] }
      end
    end
    @sizes
  end

  def uncacheSizes
    @sizes = nil
  end
end
