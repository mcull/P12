class GoodsCategoriesController < ApplicationController
  def index
    @category = GoodsCategory.new
    puts (@category)
    render :action => :new
  end

  def new
    redirect_to :action => :index
  end

  def create
    category = GoodsCategory.new(params[:goods_category]);
    if category.save then
      flash[:notice] = category.name  + " successfully added"
      redirect_to :action => :index
    else
      @category = category
      render :action => :new
    end
  end

  def edit
    @category = GoodsCategory.find(params[:id])
    render :action => :edit
  end

  def update
    @category = GoodsCategory.find(params[:id])
    if @category.update_attributes(params[:goods_category]) then
      flash[:notice] = @category.name  + " successfully saved"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    category = GoodsCategory.find(params[:id])
    category.active = 0
    category.save
    flash[:notice] = category.name  + " successfully deleted"
    redirect_to :action => :index
  end
end
