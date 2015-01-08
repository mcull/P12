require 'aws-sdk'
require 'digest'

class ShipmentsController < ApplicationController
  def create
    @xmlPayload = params[:xml]

    sqs = AWS::SQS.new(
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    )
    queue = sqs.queues.create("planetarygear_shipped")
    @msg = queue.send_message(@xmlPayload)

    ShippedMailer.shipped(@xmlPayload).deliver_now
  end
end
