class SizesController < AdminController

  def index
    @size = Size.new
    render :action => :new
  end

  def new
    redirect_to :action => :index
  end

  def edit
    @size = Size.find(params[:id])
    render :action=> :edit
  end

  def create
    @size = Size.new(params[:size]);
    @size.sort_order = 1
    if @size.save then
      flash[:notice] = @size.name  + " successfully added"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def update
    @size = Size.find(params[:id])
    if (params[:sort_order]) then #unhappy with this hack
      @size.sort_order = params[:sort_order]
    end
    if @size.update_attributes(params[:size]) then
      @size.save
      flash[:notice] = @size.name  + " successfully updated"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    size = Size.find(params[:id])
    size.active = 0
    size.save
    flash[:notice] = size.name  + " successfully deleted"
    redirect_to :action => :index
  end

end
