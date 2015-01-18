module PrinterInventoriesHelper
  def getInventoryFor(printer_inventory_list, color, size, printer, base_good)
    #inventory = PrinterInventory.new({:printer_id=>printer.id, :base_good_id=>base_good.id,:color_id=>color.id,:size_id=>size.id})
    #inventory.save
    #inventory.destroy
    inventory = PrinterInventory.new
    printer_inventory_list.each do |i|
      if (i.color_id == color.id && i.size_id == size.id)  then
        inventory = i
        break
      end
    end
    inventory
  end
end
