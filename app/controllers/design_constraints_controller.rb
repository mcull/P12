class DesignConstraintsController < AdminController
  def index
    @designConstraint = DesignConstraint.new
    render :action => :new
  end

  def new
    redirect_to :action => :index
  end

  def create
    designConstraint = DesignConstraint.new(params[:design_constraint]);
    if designConstraint.save then
      flash[:notice] = designConstraint.name  + " successfully added"
      redirect_to :action => :index
    else
      @designConstraint = designConstraint
      render :action => :new
    end
  end

  def edit
    @designConstraint = DesignConstraint.find(params[:id])
    render :action => :edit
  end

  def update
    @designConstraint = DesignConstraint.find(params[:id])
    if @designConstraint.update_attributes(params[:design_constraint]) then
      flash[:notice] = @designConstraint.name  + " successfully saved"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    designConstraint = DesignConstraint.find(params[:id])
    designConstraint.active = 0
    designConstraint.save
    flash[:notice] = designConstraint.name  + " successfully deleted"
    redirect_to :action => :index
  end
end
