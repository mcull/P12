class DesignsController < ApplicationController
  def index
    @designOwner =  DesignOwner.find_by_id(params[:design_owner_id])
    @designs = @designOwner.designs
    render :action => :index
  end

  def new
    @designOwner = DesignOwner.find_by_id(params[:design_owner_id])
    @design = Design.new
    @design.design_owner_id = @designOwner.id
    #@design = Design.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
    #render :action => :new
  end

  def show
    @design = Design.find_by_id(params[:id])
    puts(@design.design_owner.name)
  end

  def create
    design = Design.new(params[:design]);
    copy_from = params[:upload_from]
    design.image_from_url(copy_from) unless copy_from.blank?
    design.design_owner_id = params[:design_owner_id]
    if design.save then
      flash[:notice] = design.name  + " successfully added"
    end
    redirect_to :action => :index
  end

  def edit
    @design = Design.find(params[:id])
    @designOwner = @design.design_owner
    render :action => :edit
  end

  def update
    @design = Design.find(params[:id])
    copy_from = params[:upload_from]
    @design.image_from_url(copy_from) unless copy_from.blank?
    @design.image.save unless params[:design][:image].blank?
    if @design.update_attributes(params[:design]) then
      flash[:notice] = @design.name  + " successfully saved"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    design = Design.find(params[:id])
    design.active = 0
    design.save
    flash[:notice] = design.name  + " successfully deleted"
    redirect_to :action => :index
  end
end
