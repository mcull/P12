require 'peddler'

class FeedsController < AdminController

  def get_client
    client = MWS.feeds(
      marketplace_id:        ENV['MWS_MARKETPLACE_ID'],
      merchant_id:           ENV['MWS_MERCHANT_ID'],
      aws_access_key_id:     ENV['MWS_AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['MWS_AWS_SECRET_KEY']
    )
  end

  def active_submissions
    render json: get_client.get_feed_submission_list.parse
  end

  def count_submissions
    render json: get_client.get_feed_submission_count.parse
  end

  def get_result
    submission_id = params[:id]
    render json: get_client.get_feed_submission_result(submission_id).parse
  end

  def get_upc_count
  #  codes = UPCCode.where(:active=>1).count
    render json: UPCCode.where(:active=>1).count
  end





end
