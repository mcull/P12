class Design
  include Dynamoid::Document
  include Dynamoid::Paperclip

  has_dynamoid_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates_presence_of :name


  table :name => :designs, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :description
  field :design_owner_id
  field :image_updated_at, :datetime
  field :active, :integer

  def image_from_url(url)
    self.image = URI.parse(url)
  end

  def design_owner
    if @designOwner.blank? then
      @designOwner = DesignOwner.find_by_id(self.design_owner_id)
    end
    @designOwner
  end

  belongs_to :design_owner
  has_many :print_ready_art

end
