class SalesChannelsController < AdminController
  def index
    @channel = SalesChannel.new
    render :action => :new
  end

  def new
    redirect_to :action => :index
  end

  def edit
    @channel = SalesChannel.find(params[:id])
    render :action => :edit
  end

  def create
    channel = SalesChannel.new(params[:sales_channel]);
    if channel.save then
      flash[:notice] = channel.name  + " successfully added"
      redirect_to :action => :index
    else
      @channel = channel
      render :action => :edit
    end
  end

  def update
    channel = SalesChannel.find(params[:id])
    if channel.update_attributes(params[:sales_channel]) then
      flash[:notice] = channel.name  + " successfully saved"
      redirect_to :action => :index
    else
      @channel = channel
      render :action => :edit
    end
  end

  def destroy
    channel = SalesChannel.find(params[:id])
    channel.destroy
    flash[:notice] = channel.name  + " successfully deleted"
    redirect_to :action => :index
  end
end
