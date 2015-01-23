require 'peddler'

class OrdersController < AdminController

  def get_client
    client = MWS.feeds(
      marketplace_id:        ENV['MWS_MARKETPLACE_ID'],
      merchant_id:           ENV['MWS_MERCHANT_ID'],
      aws_access_key_id:     ENV['MWS_AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['MWS_AWS_SECRET_KEY']
    )
  end

  def list_orders
    render json: get_client.list_orders.parse
  end


end
