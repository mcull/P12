module ColorsHelper

  def allColors
    begin
      Color.where(:active => 1).all.sort_by { |a| [ a.name ] }
    rescue
      []
    end
  end
end
