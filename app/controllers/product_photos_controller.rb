class ProductPhotosController < ApplicationController
  def index
    @product = Product.find_by_id(params[:product_id])
  end

  def new
    @product = Product.find_by_id(params[:product_id])
    @photo = ProductPhoto.new
  end

  def create
    @product = Product.find_by_id(params[:product_id])
    @photo = ProductPhoto.new(params[:product_photo])
    @photo.product_id = @product.id
    @photo.image = params[:image]
    copy_from = params[:upload_from]
    @photo.image_from_url(copy_from) unless copy_from.blank?
    if @photo.save then
      flash[:notice] = @product.name  + " successfully added a photo"
    end
    redirect_to edit_product_path(@product)
  end

  def edit
    @product = Product.find_by_id(params[:product_id])
    @photo = ProductPhoto.find_by_id(params[:id])
  end

  def update
    @product = Product.find_by_id(params[:product_id])

    @photo = ProductPhoto.find_by_id(params[:id])
    @photo.product_id = @product.id
    @photo.image = params[:product_photo][:image]
    copy_from = params[:upload_from]
    @photo.image_from_url(copy_from) unless copy_from.blank?
    if @photo.update_attributes(params[:product_photo]) then
      flash[:notice] = @product.name  + " successfully added a photo"
    end
    redirect_to edit_product_path(@product)
  end

  def destroy
    @product = Product.find_by_id(params[:product_id])
    @photo = ProductPhoto.find_by_id(params[:id])
    @photo.destroy
    flash[:notice] = @product.name + "'s photo successfully deleted"
    redirect_to edit_product_path(@product)
  end

end
