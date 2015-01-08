module ShipmentsHelper
  def defaultShipmentXml
    '<?xml version="1.0" encoding="UTF-8"?>
    <OrderShipped>
    <UDF_ORDER_CONFIRMATION>86018147</UDF_ORDER_CONFIRMATION>
    <CustomerNo>0029131</CustomerNo>
    <CustomerPONo>54ad6a4cbba04</CustomerPONo>
    <TrackingID>1z1234567890</TrackingID>
    <PackageNo>0001</PackageNo>
    <Weight>1.00</Weight>
    <FreightAmtAddedToInv>1.00</FreightAmtAddedToInv>
    <ShipDate>2015-01-07 00:00:00</ShipDate>
    <ShipVia>DHLSMARTMAIL</ShipVia>
    </OrderShipped>'
  end

  def getMd5(text)
    md5 = Digest::MD5.new
    md5.update text
  end
end
