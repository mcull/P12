class BaseGoodPrintLocation
  include Dynamoid::Document

  table :name => :base_good_print_locations, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :base_good_id
  field :printable_location_id
  field :design_constraint_id
  field :print_mode_id

  def printableLocation
    if @printLocation.blank? then
      @printLocation = PrintableLocation.find_by_id(self.printable_location_id)
    end
    @printLocation
  end

  def designConstraint
    if @designConstraint.blank? && !self.design_constraint_id.blank? then
      @designConstraint = DesignConstraint.find_by_id(self.design_constraint_id)
    end
    @designConstraint
  end

  def printMode
    if @printMode.blank? && !self.print_mode_id.blank? then
      @printMode = PrintMode.find_by_id(self.print_mode_id)
    end
    @printMode
  end

end
