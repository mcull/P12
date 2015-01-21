class Product
  include Dynamoid::Document
  include Dynamoid::Paperclip

  has_dynamoid_attached_file :image,
    styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
    }


  table :name => :products, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :base_good_id
  field :design_id
  field :name
  field :sales_channel_id

  field :markup, :float

  field :num_of_additional_photos, :integer
  field :active, :integer

  def image_from_url(url)
    self.image = URI.parse(url)
  end

  def name
    if (!design.blank? && !baseGood.blank?) then
      self.design.name + " " + self.baseGood.name
    else
      "New Product"
    end
  end

  def design
    if @design.blank? then
      @design = self.design_id.blank? ? nil : Design.find_by_id(self.design_id)
    end
    @design
  end

  def baseGood
    if @baseGood.blank? then
      @baseGood = self.base_good_id.blank? ? nil : BaseGood.find_by_id(self.base_good_id)
    end
    @baseGood
  end

  def photos
    if @photos.blank? then
      @photos = Array.new
      @photos = ProductPhoto.where(:product_id => self.id).all
      if (!@photos.blank?) then
        @photos.sort_by! { |a| [ a.created_at ] }
      end
    end
    @photos
  end

end
