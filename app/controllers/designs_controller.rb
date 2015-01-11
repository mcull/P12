class DesignsController < ApplicationController
  def index
    @design = Design.new
    render :action => :index
  end

  def new
    @design = Design.new
    render :action => :new
  end

  def create
    design = Design.new(params[:design]);
    copy_from = params[:upload_from]
    design.image_from_url(copy_from) unless copy_from.blank?
    if design.save then
      flash[:notice] = design.name  + " successfully added"
    end
    redirect_to :action => :new
  end

  def edit
    @design = Design.find(params[:id])
    render :action => :edit
  end

  def update
    @design = Design.find(params[:id])
    if @design.update_attributes(params[:design]) then
      flash[:notice] = @design.name  + " successfully saved"
      redirect_to :action => :new
    else
      render :action => :edit
    end
  end

  def destroy
    design = Design.find(params[:id])
    design.active = 0
    design.save
    flash[:notice] = design.name  + " successfully deleted"
    redirect_to :action => :new
  end
end
