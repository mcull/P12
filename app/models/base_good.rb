class BaseGood
  include Dynamoid::Document

  table :name => :base_goods, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :goods_category_id
  field :name
  field :description
  field :size_chart_uri

  field :active, :integer

  def goodsCategory
    ""
  end

  def printModes
    if @printModes.blank? then
      @printModes = Array.new
      modes = BaseGoodPrintMode.where(:base_good_id => self.id).all
      if (!modes.blank?) then
        modes.each do |bgpm|
          @printModes.push(PrintMode.find_by_id(bgpm.print_mode_id))
        end
      end
    end
    @printModes
  end

  def uncachePrintModes
    @printModes = nil
  end

  def printLocations
    if @printLocations.blank? then
      @printLocations = Array.new
      locations = BaseGoodPrintLocation.where(:base_good_id => self.id).all
      if (!locations.blank?) then
        locations.each do |bgpl|
          @printLocations.push(PrintableLocation.find_by_id(bgpl.printable_location_id))
        end
      end
    end
    @printLocations
  end

  def uncachePrintLocations
    @printLocations = nil
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
