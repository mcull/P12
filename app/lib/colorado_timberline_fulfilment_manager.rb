require 'uri'
require 'net/http'

class ColoradoTimberlineFulfilmentManager < FulfilmentHandler

  def get_printer_id
    if (@printer_id.blank?) then
      @printer_id = Printer.find_by_name("Colorado Timberline").id
    end
    @printer_id
  end

  def send_order(order)
    xml = '<?xml version="1.0"?>'
    xml += '<Order AffiliateID="'
    xml += ENV['COLORADO_TIMBERLINE_AFFILIATE_ID']
    xml += '" OrderID=“'
    xml += order.id
    xml += '">'
    xml += '<ShipToName>' + order.ship_name + '</ShipToName>'
    xml += '<AddressLine1>' + order.ship_address_1 + '</AddressLine1>'
    if (!order.ship_address_2.blank?) then
      xml += '<AddressLine2>' + order.ship_address_2 + '</AddressLine1>'
    end
    xml += '<City>' + order.city + '</City>'
    xml += '<State>' + order.state + '</State>'
    xml += '<Zip>' + order.postal_code + '</Zip>'
    xml += '<Country>' + order.country + '</Country>'
    xml += '<ShipMethod>DHLSMARTMAIL</ShipMethod>'

    xml += '<PackingListInformation>'
    xml += '<Logo URL="https://s3.amazonaws.com/p8gear/img/curliceu_logo.png" ></Logo>'
    xml += '<Message1>Thanks for your order!</Message1>'
    xml += '<Message2>Amazon Order ID: ' + order.sales_channel_order_id + '</Message2>'
    xml += '<Message3></Message3>'
    xml += '<OrderDate>' + order.purchase_date.strftime("%m/%d/%Y") + '</OrderDate>'
    xml += '<SoldToName></SoldToName>'
    xml += '<SoldToAddressLine1></SoldToAddressLine1>'
    xml += '<SoldToAddressLine2></SoldToAddressLine2>'
    xml += '<SoldToAddressLine3></SoldToAddressLine3>'
    xml += '<SoldToCity></SoldToCity>'
    xml += '<SoldToCountry></SoldToCountry>'
    xml += '<SoldToState></SoldToState>'
    xml += '<SoldToProvince></SoldToProvince>'
    xml += '<SoldToZip></SoldToZip>'
    xml += '</PackingListInformation>'

    order.items.each do |item|
      product = Product.find_by_id(item.product_id)
      xml += '<Merchandise Quantity="'
      xml += item.quantity_ordered.to_s
      xml += '" ItemID="'
      xml += item.id
      xml += '">'
      xml += '<PartNumber>' + get_part_no_for(product,item.color_id,item.size_id) + '</PartNumber>'
      xml += '<Printmode>' + product.baseGood.printableLocationConfig.printMode.printer_name + '</Printmode>'
      xml += '<ImageSet>'
      xml += '<Image URL="' + get_print_ready_art_for(product).image.url + '" ViewName="' + product.baseGood.printableLocationConfig.printableLocation.name + '"/>'
      xml += '</ImageSet>'
      xml += '<PackageListOverride>'
      xml += '<ItemName></ItemName>'
      xml += '<ItemDescription></ItemDescription>'
      xml += '</PackageListOverride>'
      xml += '</Merchandise>'
    end
    xml += '</Order>'
    puts xml

    uri = URI("http://api.staging.co-timber.com/v15/submit")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path)
    request["xml"] = xml
    http.request(request).body
  end

  def get_print_ready_art_for(product)
    constraint_id = product.baseGood.printableLocationConfig.designConstraint.id
    PrintReadyArt.where(:design_id => product.design_id)
                 .where(:design_constraint_id => constraint_id).first

  end

  def get_part_no_for(product, color_id, size_id)
      PrinterInventory.where(:printer_id=> get_printer_id)
                      .where(:base_good_id => product.baseGood.id)
                      .where(:color_id => color_id)
                      .where(:size_id => size_id).first.shelf_sku
  end
end
