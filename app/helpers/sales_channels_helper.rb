module SalesChannelsHelper
  def allChannels
    begin
      SalesChannel.limit(100).sort_by { |a| [ a.name ] }
    rescue
      []
    end
  end
end
