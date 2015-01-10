module PrintableLocationsHelper
  def allPrintableLocations
    begin
      PrintableLocation.where(:active => 1).all.sort_by { |a| [ a.name ] }
    rescue
      []
    end
  end
end
