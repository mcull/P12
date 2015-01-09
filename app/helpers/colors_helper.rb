module ColorsHelper

  def allColors
    begin
      Color.limit(100).sort_by { |a| [ a.name ] }
    rescue
      []
    end
  end
end
