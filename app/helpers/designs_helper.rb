module DesignsHelper
  def designsByOwner(owner_id,num_of_records,start_at)
    begin
      Design.where(:owner_id => owner_id).limit(num_of_records).start_at(start_at)
    rescue
      []
    end
  end

  def owners
    retVal = Array.new
    allDesignOwners.each {|dOwner| retVal.push([dOwner.name,dOwner.id])}
    return retVal
  end
end
