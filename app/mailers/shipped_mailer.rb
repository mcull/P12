class ShippedMailer < ActionMailer::Base
  default from: 'admin@soniramllc.com'
  def shipped(xmlPayload)
    @xmlPayload = xmlPayload
    mail(to: 'admin@soniramllc.com', subject: 'Order Shipped')
  end
end
