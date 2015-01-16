class PrintReadyArt
  include Dynamoid::Document
  include Dynamoid::Paperclip

  has_dynamoid_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }


  table :name => :print_ready_art, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :media_uri
  field :design_id
  field :design_constraint_id

  field :active, :integer

  def image_from_url(url)
    self.image = URI.parse(url)
  end

  def design_constraint
    if @design_constraint.blank? then
        @design_constraint = DesignConstraint.find_by_id(self.design_constraint_id)
    end
    @design_constraint
  end

  def design
    if @design.blank? then
      @design = Design.find_by_id(self.design_id)
    end
    @design
  end

end
