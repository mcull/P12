module DesignOwnersHelper
  def allDesignOwners
    begin
      DesignOwner.where(:active => 1).all.sort_by { |a| [ a.name ] }
    rescue
      []
    end
  end
end
