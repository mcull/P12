module SizesHelper
  def allSizes
    begin
       Size.where(:active => 1).sort_by { |a| [ a.sort_order, a.name ] }
    rescue
      []
    end
  end
end
