module SalesChannelsHelper
  def allChannels
    begin
      SalesChannel.where(:active => 1).all.sort_by { |a| [ a.name ] }
    rescue
      []
    end
  end
end
