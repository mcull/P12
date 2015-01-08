class ShippedMailer < ActionMailer::Base
  default from: 'admin@soniramllc.com'
  def shipped()
    mail(to: 'admin@soniramllc.com', subject: 'Order Shipped')
  end
end
