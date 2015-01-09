class ColorsController < ApplicationController

  def index
    @color = Color.new
    render :action => :new
  end

  def new
    redirect_to :action => :index
  end

  def create
    color = Color.new(params[:color]);
    color.save
    flash[:notice] = color.name  + " successfully added"
    redirect_to :action => :index
  end

  def destroy
    color = Color.find(params[:id])
    color.destroy
    flash[:notice] = color.name  + " successfully deleted"
    redirect_to :action => :index
  end
end
