class PrintReadyArtsController < ApplicationController
  def index
    @designOwner =  DesignOwner.find_by_id(params[:design_owner_id])
    @designs = @designOwner.designs
    render :action => :index
  end

  def new
    @designOwner = DesignOwner.find_by_id(params[:design_owner_id])
    @design = Design.find_by_id(params[:design_id])
    @printReadyArt = PrintReadyArt.new
    @printReadyArt.design_id = @design.id
    render :action => :new
  end

  def show
    @design = Design.find_by_id(params[:id])
    puts(@design.design_owner.name)
  end

  def create
    art = PrintReadyArt.new(params[:print_ready_art])
    art.design_id = params[:design_id]
    owner = params[:design_owner_id]
    copy_from = params[:upload_from]
    art.image_from_url(copy_from) unless copy_from.blank?
    if art.save then
      flash[:notice] = art.design_constraint.name  + " successfully added"
    end
    redirect_to edit_design_owner_design_path(art.design.design_owner, art.design)
  end

  def edit
    @designOwner = DesignOwner.find_by_id(params[:design_owner_id])
    @design = Design.find(params[:id])
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
