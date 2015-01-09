class SizesController < ApplicationController

  def index
    @size = Size.new
    render :action => :new
  end

  def new
    redirect_to :action => :index
  end

  def create
    size = Size.new(params[:size]);
    size.sort_order = 1
    size.save
    flash[:notice] = size.name  + " successfully added"
    redirect_to :action => :index
  end

  def destroy
    size = Size.find(params[:id])
    size.destroy
    flash[:notice] = size.name  + " successfully deleted"
    redirect_to :action => :index
  end

  def update
    size = Size.find(params[:id])
    size.sort_order = params[:sort_order].to_i
    size.save
    redirect_to :action => :index
  end
end
