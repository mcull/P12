class FulfilmentController < ApplicationController
  def submit_orders
    render :text => ColoradoTimberlineFulfilmentManager.new.process_outstanding_orders
  end
end
