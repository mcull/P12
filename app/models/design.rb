class Design
  include Dynamoid::Document

  validates_presence_of :name

  table :name => :designs, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :description
  field :design_owner_id
  field :tags

  field :active, :integer

  def design_owner
    if @designOwner.blank? then
      @designOwner = DesignOwner.find_by_id(self.design_owner_id)
    end
    @designOwner
  end

  def print_ready_art
    if @printReadyArt.blank? then
      @printReadyArt = PrintReadyArt.where(:design_id => self.id).where(:active => 1)
    end
    @designOwner
  end

end
