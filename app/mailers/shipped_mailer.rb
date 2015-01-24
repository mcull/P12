class ShippedMailer < ActionMailer::Base
  default from: 'admin@curlic.eu'
  def shipped(xmlPayload)
    @xmlPayload = xmlPayload
    mail(to: 'admin@curlic.eu', subject: 'Order Shipped')
  end
end
