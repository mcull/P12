module BaseGoodsHelper

  def allBaseGoods
    begin
      BaseGood.where(:active => 1).all.sort_by { |a| [ a.name ] }
    rescue
      []
    end
  end

  def selectedColors(baseGood)
    selected = Array.new
    allColors.each_with_index do |value, index|
      if baseGood.colors.any? { |c| c.id == value.id }  then
        selected.push(value.id)
      end
    end
    selected
  end

  def selectedSizes(baseGood)
    selected = Array.new
    allSizes.each_with_index do |value, index|
      if baseGood.sizes.any? { |v| v.id == value.id }  then
        selected.push(value.id)
      end
    end
    selected
  end

  def selectedPrintModes(baseGood)
    selected = Array.new
    allPrintModes.each_with_index do |value, index|
      if baseGood.printModes.any? { |v| v.id == value.id }  then
        selected.push(value.id)
      end
    end
    selected
  end

  def selectedPrintLocations(baseGood)
    selected = Array.new
    allPrintableLocations.each_with_index do |value, index|
      if baseGood.printLocations.any? { |v| v.id == value.id }  then
        selected.push(value.id)
      end
    end
    selected
  end
end
