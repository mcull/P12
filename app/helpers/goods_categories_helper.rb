module GoodsCategoriesHelper
  def allGoodsCategories
    begin
      GoodsCategory.where(:active => 1).all.sort_by { |a| [ a.name ] }
    rescue
      []
    end
  end
end
