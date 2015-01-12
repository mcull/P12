module PrintReadyArtHelper
  def allPrintReadyArt(design_id)

    begin
      PrintReadyArt.where(:design_id => design_id).where(:active=>1).all
    rescue
      []
    end
  end
end
