module PrintersHelper
  def allPrinters
    begin
      Printer.where(:active => 1).all.sort_by { |a| [ a.name ] }
    rescue
      []
    end
  end
end
