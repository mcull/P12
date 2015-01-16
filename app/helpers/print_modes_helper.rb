module PrintModesHelper
  def allPrintModes
    begin
      PrintMode.where(:active => 1).all.sort_by { |a| [ a.printer_name ] }
    rescue
      []
    end
  end
end
