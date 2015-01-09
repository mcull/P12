class PrintersController < ApplicationController

  def index
    @printer = Printer.new
    render :action => :new
  end

  def new
    redirect_to :action => :index
  end

  def create
    printer = Printer.new(params[:printer]);
    if printer.valid? then
      printer.save
      flash[:notice] = printer.name  + " successfully added"
      redirect_to :action => :index
    else
      @printer = printer
      render :action => :edit
    end

  end

  def update
    printer = Printer.find(params[:id])
    if printer.update_attributes(params[:printer]) then
      flash[:notice] = printer.name  + " successfully saved (" + printer.id + ")"
      redirect_to :action => :index
    else
      @printer = printer
      render :action => :edit
    end

  end

  def edit
    @printer =  Printer.find(params[:id])
    render :action => :new
  end

  def destroy
    printer = Printer.find(params[:id])
    printer.active = 0
    printer.save
    flash[:notice] = printer.name  + " successfully deleted"
    redirect_to :action => :index
  end
end
