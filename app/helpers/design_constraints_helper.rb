module DesignConstraintsHelper
  def allDesignConstraints
    begin
      DesignConstraint.where(:active => 1).all.sort_by { |a| [ a.name ] }
    rescue
      []
    end
  end
end
