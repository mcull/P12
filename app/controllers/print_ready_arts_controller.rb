class PrintReadyArtsController < ApplicationController
  def index
    @designOwner =  DesignOwner.find_by_id(params[:design_owner_id])
    @designs = @designOwner.designs
    render :action => :index
  end

  def new
    @design = Design.find_by_id(params[:design_id])
    @designOwner = @design.design_owner
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
    copy_from = params[:upload_from]
    art.image_from_url(copy_from) unless copy_from.blank?
    if art.save then
      flash[:notice] = art.design_constraint.name  + " successfully added"
    end
    redirect_to edit_design_owner_design_path(art.design.design_owner, art.design)
  end

  def edit
    @printReadyArt = PrintReadyArt.find_by_id(params[:id])
    @printReadyArt.design_id = params[:design_id]
    @design = @printReadyArt.design
    @designOwner = @design.design_owner.target


    render :action => :edit
  end

  def update
    art = PrintReadyArt.find(params[:id])
    art.design_id = params[:design_id]
    copy_from = params[:upload_from]
    if art.update_attributes(params[:print_ready_art]) then
      flash[:notice] = art.getDesign.name  + " successfully saved"
    end
    redirect_to edit_design_owner_design_path(art.getDesign.getDesignOwner, art.getDesign)
  end

  def destroy
    art = PrintReadyArt.find(params[:id])
    art.active = 0
    art.save
    flash[:notice] = art.getDesign.name + ": " + art.getDesignConstraint.name  + " successfully deleted"
    redirect_to edit_design_owner_design_path(art.getDesign.getDesignOwner, art.getDesign)
  end
end
