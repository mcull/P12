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

  belongs_to :design_owner
  has_many :print_ready_art
  
  attr_accessor :creative_uploaded

  before_save :upload_new_creative_if_necessary

  private

  def upload_new_creative_if_necessary
    if creative_uploaded
      # force update of the creative
      image.save
    end
  end
end
