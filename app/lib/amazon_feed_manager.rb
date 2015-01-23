require 'peddler'

class AmazonFeedManager
  MESS = "SYSTEM ERROR: method missing"

  def get_template; raise MESS; end
  def get_parent_line(product,upc); raise MESS; end
  def get_child_line(product,upc,color,size); raise MESS; end

    def update_feed(product)
      #get the upc codes for this product
      upc_codes = UPCCode.where(:product_id => product.id).all
      p upc_codes

      #write the header
      line_num=0
      header_line = File.open(Rails.root.join("app","data","feeds", get_template())).read
      feed_file = header_line.chomp
      feed_file.gsub! ",","\t"


      #write the parent
      feed_file += "\n" + get_parent_line(product)

      #write every child
      product.baseGood.colors.each do |c|
        product.baseGood.sizes.each do |s|
          child_upc = upc_codes.find { |u| u.color_id == c.id && u.size_id == s.id }
          if (child_upc.blank?) then
            puts "didn't find upc for " + c.id + " and " + s.id
            child_upc = UPCCode.next
            child_upc.product_id = product.id
            child_upc.color_id = c.id
            child_upc.size_id = s.id
            child_upc.save
          end
          feed_file += "\n" + get_child_line(product,child_upc,c,s)
        end
      end

      #upload this all to amazon
      client = MWS.feeds(
        marketplace_id:        ENV['MWS_MARKETPLACE_ID'],
        merchant_id:           ENV['MWS_MERCHANT_ID'],
        aws_access_key_id:     ENV['MWS_AWS_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['MWS_AWS_SECRET_KEY']
      )

      response = client.submit_feed(feed_file, :_POST_FLAT_FILE_LISTINGS_DATA_, opts = {})
      puts response.parse

      #File.open(Rails.root + "out/feed.csv", 'w') { |file| file.write(feed_file) }

    end

    def init_line
      line = Array.new
      num_of_cols.times do
        line.push('')
      end
      line
    end

end
