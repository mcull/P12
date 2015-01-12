module DesignsHelper
  def designsByOwner(owner_id)
    begin
      Design.where(:design_owner_id => owner_id).where(:active => 1).all.sort_by { |a| [ a.created_at ] }.reverse
    rescue
      []
    end
  end

  def allPrintReadyArt(design_id)
    begin
      PrintReadyArt.where(:design_id => self.id).where(:active=>1).all
    rescue
      []
    end
  end



  def allDesigns
    Design.where(:active => 1).all.sort_by { |a| [ a.created_at ] }
  end

  def owners
    retVal = Array.new
    allDesignOwners.each {|dOwner| retVal.push([dOwner.name,dOwner.id])}
    return retVal
  end
end
