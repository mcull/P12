class SalesChannelsController < ApplicationController
  def index
    @channel = SalesChannel.new
    render :action => :new
  end

  def new
    redirect_to :action => :index
  end

  def create
    channel = SalesChannel.new(params[:sales_channel]);
    channel.save
    flash[:notice] = channel.name  + " successfully added"
    redirect_to :action => :index
  end

  def destroy
    channel = SalesChannel.find(params[:id])
    channel.destroy
    flash[:notice] = channel.name  + " successfully deleted"
    redirect_to :action => :index
  end
end
