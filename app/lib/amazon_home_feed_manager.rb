
class AmazonHomeFeedManager < AmazonFeedManager
  def get_template
    "home.csv"
  end

  def num_of_cols
    255
  end

  def get_parent_line(product)
    vals = init_line
    vals[0]   = product.short_id + "_P"
    vals[6]   = product.name
    vals[8]   = :Home
    vals[12]  = 'throw-pillows'
    vals[9]   = :Curliceu
    vals[10]  = :Curliceu
    vals[119] = :parent
    vals[122] = 'Size-Color'
    vals.join("\t")
  end

  def get_child_line(product,upc,color,size)
    vals = init_line
    vals[0]   = product.short_id + "_C=" + color.short_id + "_S=" + size.short_id
    vals[1]   = upc.code
    vals[2]   = :UPC
    vals[6]   = product.name + " " +  color.name + " " + size.name
    vals[7]   = product.baseGood.description.gsub(/\n/," ").gsub(/\r/," ") + "<p>" + product.design.description.gsub(/\n/," ").gsub(/\r/," ")
    vals[8]   = :Home
    vals[9]   = :Curliceu
    vals[10]  = :Curliceu
    vals[12]  = 'throw-pillows'
    vals[13]  = :update

    vals[15]  = ((((product.baseGood.price + (size.additional_price || 0.0)) * 1.3).ceil) - 0.01).to_f.round(2)
    vals[16]  = :USD
    vals[17]  = :New
    vals[19]  = 1000
    vals[22]  = '2015-01-21'
    vals[27]  = (product.baseGood.price + (size.additional_price || 0.0)).ceil
    vals[28]  = '2015-01-01'
    vals[29]  = '2020-01-01'
    vals[31]  = 1
    vals[40]  = 1
    vals[41]  = :LB
    vals[50]  = 1
    vals[51]  = :LB
    vals[57]  = 1
    vals[58]  = :LB
    vals[62]  = product.baseGood.bullet1
    vals[63]  = product.baseGood.bullet2
    vals[64]  = product.baseGood.bullet3
    vals[65]  = product.baseGood.bullet4
    vals[66]  = product.baseGood.bullet5
    vals[78]  = :adults
    tags = product.design.tags.split(",")
    if (!tags.blank?) then
      tags.each_with_index {|item, index|
        break unless index < 5
        vals[91+index] = item
      }
    end
    vals[101] = product.image.url
    if (!product.photos.blank?) then
      product.photos.each_with_index {|item, index|
        break unless index < 5
        vals[103 + index] = item.image.url
      }
    end
    vals[119] = :child
    vals[120] = product.short_id + "_P"
    vals[121] = :Variation
    vals[122] = 'Size-Color'
    vals[129] = :US
    vals[130] = :US
    vals[133] = "100% spun polyester poplin"
    vals[156] = color.name
    vals[157] = color.amazon_color_map
    vals[158] = size.name
    vals[159] = :Fabric
    vals[161] = 'Country Rustic'
    vals.join("\t")
  end
end
