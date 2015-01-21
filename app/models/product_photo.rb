class ProductPhoto
  include Dynamoid::Document
  include Dynamoid::Paperclip

  has_dynamoid_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  table :name => :products, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :product_id

  def image_from_url(url)
    self.image = URI.parse(url)
  end

end
