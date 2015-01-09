module SizesHelper
  def allSizes
    begin
       Size.limit(100).sort_by { |a| [ a.sort_order, a.name ] }
    rescue
      []
    end
  end
end
