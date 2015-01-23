module AmazonListable
  extend ActiveSupport::Concern

  included do
    is_amazon_listable
  end
end
