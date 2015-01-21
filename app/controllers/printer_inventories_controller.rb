class PrinterInventoriesController < AdminController
  def index
    @printer = Printer.find_by_id(params[:printer_id])
    @base_good = BaseGood.find_by_id(params[:base_good_id])
    @printer_inventories = PrinterInventory.where(:printer_id=>@printer.id,:base_good_id=>@base_good.id).all
  end

  def create
    @printer = Printer.find_by_id(params[:printer_id])
    @base_good = BaseGood.find_by_id(params[:base_good_id])
    @printer_inventory = PrinterInventory.new(params[:printer_inventory])
    @printer_inventory.printer_id = params[:printer_id]
    @printer_inventory.base_good_id = params[:base_good_id]
    @printer_inventory.color_id = params[:color_id]
    @printer_inventory.size_id = params[:size_id]
    if (@printer_inventory.save) then
      flash[:notice] = @printer_inventory.shelf_sku  + " successfully added"
    end
    redirect_to :action => :index
  end

  def update
    @printer = Printer.find_by_id(params[:printer_id])
    @base_good = BaseGood.find_by_id(params[:base_good_id])
    @printer_inventory = PrinterInventory.find(params[:id])
    if (@printer_inventory.update_attributes(params[:printer_inventory])) then
      flash[:notice] = @printer_inventory.shelf_sku  + " successfully updated"
    end
    redirect_to :action => :index
  end
end
