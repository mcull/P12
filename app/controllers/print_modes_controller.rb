class PrintModesController < AdminController
  def index
    @printMode = PrintMode.new
    render :action => :new
  end

  def new
    redirect_to :action => :index
  end

  def create
    @printMode = PrintMode.new(params[:print_mode]);
    if @printMode.save then
      flash[:notice] = @printMode.printer_name  + " successfully added"
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def edit
    @printMode = PrintMode.find(params[:id])
    render :action => :edit
  end

  def update
    @printMode = PrintMode.find(params[:id])
    if @printMode.update_attributes(params[:print_mode]) then
      flash[:notice] = @printMode.printer_name  + " successfully saved"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    printMode = PrintMode.find(params[:id])
    printMode.active = 0
    printMode.save
    flash[:notice] = printMode.printer_name  + " successfully deleted"
    redirect_to :action => :index
  end
end
