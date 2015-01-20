class BaseGoodsController < ApplicationController


  def new
    @baseGood = BaseGood.new
    #redirect_to :action => :index
  end

  def saveBaseGoodColors(baseGoodColors,id)
    if (!baseGoodColors.blank?) then
      baseGoodColors.each do |c|
        if !c.blank? then
          bg_color = BaseGoodColor.new
          bg_color.color_id = c
          bg_color.base_good_id = id
          bg_color.save
        end
      end
    end
  end

  def saveBaseGoodSizes(baseGoodSizes,id)
    if (!baseGoodSizes.blank?) then
      baseGoodSizes.each do |s|
        if !s.blank? then
          bg_size = BaseGoodSize.new
          bg_size.size_id = s
          bg_size.base_good_id = id
          bg_size.save
        end
      end
    end
  end

  def deleteAllBaseGoodColors(baseGood)
    baseGood.colors.each do |bgc|
      BaseGoodColor.where(:color_id=>bgc.id).where(:base_good_id=>baseGood.id).all.each do |d|
        d.destroy
      end
    end
  end

  def deleteAllBaseGoodSizes(baseGood)
    baseGood.sizes.each do |bgs|
      BaseGoodSize.where(:size_id=>bgs.id).where(:base_good_id=>baseGood.id).all.each do |d|
        d.destroy
      end
    end
  end

  def savePrintLocation(params,baseGood)
    printLocation = BaseGoodPrintLocation.new({
      :base_good_id=>baseGood.id,
      :printable_location_id=>params[:printable_location],
      :design_constraint_id=>params[:design_constraint],
      :print_mode_id=>params[:print_mode]
      })
      printLocation.save
  end



  def create
    @baseGood = BaseGood.new(params[:base_good])

    if @baseGood.save then
      saveBaseGoodColors(params[:colors],@baseGood.id)
      saveBaseGoodSizes(params[:sizes],@baseGood.id)
      savePrintLocation(params,@baseGood)
      flash[:notice] = @baseGood.name  + " successfully added"
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def edit
    @baseGood = BaseGood.find(params[:id])
    render :action => :edit
  end

  def update
    @baseGood = BaseGood.find(params[:id])
    if @baseGood.update_attributes(params[:base_good]) then
      deleteAllBaseGoodColors(@baseGood)
      @baseGood.uncacheColors
      deleteAllBaseGoodSizes(@baseGood)
      @baseGood.uncacheSizes
      saveBaseGoodColors(params[:colors],@baseGood.id)
      saveBaseGoodSizes(params[:sizes],@baseGood.id)

      @printLocation = @baseGood.printableLocationConfig
      if (@printLocation.blank?) then
        savePrintLocation(params,@baseGood)
      else

        @printLocation.update_attributes({
          :base_good_id=>@baseGood.id,
          :printable_location_id=>params[:printable_location],
          :design_constraint_id=>params[:design_constraint],
          :print_mode_id=>params[:print_mode]
          })
      end

      flash[:notice] = @baseGood.name  + " successfully saved"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    baseGood = BaseGood.find(params[:id])
    baseGood.active = 0
    if baseGood.save
      deleteAllBaseGoodColors(baseGood)
      deleteAllBaseGoodSizes(baseGood)
      deleteAllBaseGoodPrintModes(baseGood)
      flash[:notice] = baseGood.name  + " successfully deleted"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end
end
