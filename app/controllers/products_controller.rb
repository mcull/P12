class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    product = Product.new(params[:product])
    copy_from = params[:upload_from]
    art.image_from_url(copy_from) unless copy_from.blank?
    if product.save then
      flash[:notice] = product.name  + " successfully added"
    end
    redirect_to :action => :index
  end

  def edit
    @product = Product.find_by_id(params[:id])
    render :action => :edit
  end

  def update
    @product = Product.find(params[:id])
    copy_from = params[:upload_from]
    if (!params[:product][:image].blank?) then
      @product.image = params[:product][:image]
    end
    @product.image_from_url(copy_from) unless copy_from.blank?
    if @product.update_attributes(params[:product]) then
      flash[:notice] = @product.name  + " successfully saved"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    @product = Product.find_by_id(params[:id])
    @product.active = 0
    if @product.save then
      flash[:notice] = @product.name  + " successfully deleted"
      redirect_to :action => :index
    else
      render :action => :edit
    end

  end

  def remove_main_photo
    @product = Product.find(params[:id])
    @product.image = nil
    @product.save
    flash[:notice] = @product.name  + " image removed."
    render :action => :edit
  end

  def update_amazon_listing
    @product = Product.find(params[:id])
    @product.update_amazon_listing
    flash[:notice] = @product.name  + " feed updated."

    redirect_to :action => :edit
  end

end
