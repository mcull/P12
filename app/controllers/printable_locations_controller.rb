class PrintableLocationsController < AdminController
  def index
    @printableLocation = PrintableLocation.new
    render :action => :new
  end

  def new
    redirect_to :action => :index
  end

  def create
    printableLocation = PrintableLocation.new(params[:printable_location]);
    if printableLocation.save then
      flash[:notice] = printableLocation.name  + " successfully added"
      redirect_to :action => :index
    else
      @printableLocation = printableLocation
      render :action => :new
    end
  end

  def edit
    @printableLocation = PrintableLocation.find(params[:id])
    render :action => :edit
  end

  def update
    @printableLocation = PrintableLocation.find(params[:id])
    if @printableLocation.update_attributes(params[:printable_location]) then
      flash[:notice] = @printableLocation.name  + " successfully saved"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    printableLocation = PrintableLocation.find(params[:id])
    printableLocation.active = 0
    printableLocation.save
    flash[:notice] = printableLocation.name  + " successfully deleted"
    redirect_to :action => :index
  end
end
