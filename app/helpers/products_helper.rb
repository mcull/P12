module ProductsHelper
  def allProducts
    begin
      Product.where(:active => 1).all.sort_by { |a| [ a.created_at ] }.reverse
    rescue
      []
    end
  end

end
