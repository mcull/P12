class ColorsController < AdminController

  def index
    @color = Color.new
    render :action => :new
  end

  def new
    redirect_to :action => :index
  end

  def create
    @color = Color.new(params[:color]);
    if @color.save then
      flash[:notice] = @color.name  + " successfully added"
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def edit
    @color = Color.find(params[:id])
    render :action => :edit
  end

  def update
    @color = Color.find(params[:id])
    if @color.update_attributes(params[:color]) then
      flash[:notice] = @color.name  + " successfully saved"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    color = Color.find(params[:id])
    color.active = 0
    color.save
    flash[:notice] = color.name  + " successfully deleted"
    redirect_to :action => :index
  end
end
