require 'peddler'

class OrdersController < ApplicationController

  def get_client
    MWS.orders(
      marketplace_id:        ENV['MWS_MARKETPLACE_ID'],
      merchant_id:           ENV['MWS_MERCHANT_ID'],
      aws_access_key_id:     ENV['MWS_AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['MWS_AWS_SECRET_KEY']
    )

  end

  def list_orders
    render json: AmazonOrderManager.get_new_orders.parse
  end

  def process_new_orders
    render json: AmazonOrderManager.process_new_orders
  end

  def list_order_items
    @order_id = params[:id]
    render json: AmazonOrderManager.get_order_items(@order_id).parse
  end


end
