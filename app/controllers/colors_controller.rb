class ColorsController < ApplicationController

  def new
    @color = Color.new
  end
  def create
    @color = Color.new(params[:color]);
    @color.save
    
    @color = Color.new
    render :action => 'new'
  end
end
