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
          puts(">>> JUST TRIED SAVING COLOR...?")
        end
      end
    else
      puts(">>>BLANK?? COLOR...?")
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

  def saveBaseGoodPrintModes(baseGoodPrintModes,id)
    if (!baseGoodPrintModes.blank?) then
      baseGoodPrintModes.each do |pm|
        if !pm.blank? then
          bg_print_mode = BaseGoodPrintMode.new
          bg_print_mode.print_mode_id = pm
          bg_print_mode.base_good_id = id
          bg_print_mode.save
        end
      end
    end
  end

  def saveBaseGoodPrintLocations(baseGoodPrintLocations,id)
    if (!baseGoodPrintLocations.blank?) then
      baseGoodPrintLocations.each do |pl|
        if !pl.blank? then
          bg_print_location = BaseGoodPrintLocation.new
          bg_print_location.printable_location_id = pl
          bg_print_location.base_good_id = id
          bg_print_location.save
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

  def deleteAllBaseGoodPrintModes(baseGood)
    baseGood.printModes.each do |bgpm|
      BaseGoodPrintMode.where(:print_mode_id=>bgpm.id).where(:base_good_id=>baseGood.id).all.each do |d|
        d.destroy
      end
    end
  end

  def deleteAllBaseGoodPrintLocations(baseGood)
    baseGood.printLocations.each do |bgpl|
      BaseGoodPrintMode.where(:printable_location_id=>bgpl.id).where(:base_good_id=>baseGood.id).all.each do |d|
        d.destroy
      end
    end
  end

  def create
    @baseGood = BaseGood.new(params[:base_good])

    if @baseGood.save then
      saveBaseGoodColors(params[:colors],@baseGood.id)
      saveBaseGoodSizes(params[:sizes],@baseGood.id)
      saveBaseGoodPrintModes(params[:print_modes],@baseGood.id)
      saveBaseGoodPrintLocations(params[:printable_locations],@baseGood.id)
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
      deleteAllBaseGoodPrintModes(@baseGood)
      @baseGood.uncachePrintModes
      deleteAllBaseGoodPrintLocations(@baseGood)
      @baseGood.uncachePrintLocations

      saveBaseGoodColors(params[:colors],@baseGood.id)
      saveBaseGoodSizes(params[:sizes],@baseGood.id)
      saveBaseGoodPrintModes(params[:print_modes],@baseGood.id)
      saveBaseGoodPrintLocations(params[:printable_locations],@baseGood.id)

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
