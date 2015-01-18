class DesignOwner
  include Dynamoid::Document

  table :name => :design_owners, :key => :id, :read_capacity => 5, :write_capacity => 2

  field :name
  field :contact_email

  field :active, :integer

  def designs
      if @designs.blank? then
        @designs = Design.where(:design_owner_id => self.id).all.sort_by { |a| [ a.created_at ] }.reverse
      end
      @designs
  end

end
