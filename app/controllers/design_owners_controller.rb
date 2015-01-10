class DesignOwnersController < ApplicationController
    def index
      @designOwner = DesignOwner.new
      render :action => :new
    end

    def new
      redirect_to :action => :index
    end

    def create
      designOwner = DesignOwner.new(params[:design_owner]);
      if designOwner.save then
        flash[:notice] = designOwner.name  + " successfully added"
        redirect_to :action => :index
      else
        @designOwner = designOwner
        render :action => :edit
      end

    end

    def update
      designOwner = DesignOwner.find(params[:id])
      if designOwner.update_attributes(params[:design_owner]) then
        flash[:notice] = designOwner.name  + " successfully saved (" + designOwner.id + ")"
        redirect_to :action => :index
      else
        @designOwner = designOwner
        render :action => :edit
      end

    end

    def edit
      @designOwner =  DesignOwner.find(params[:id])
      render :action => :new
    end

    def destroy
      designOwner = DesignOwner.find(params[:id])
      designOwner.active = 0
      designOwner.save
      flash[:notice] = designOwner.name  + " successfully deleted"
      redirect_to :action => :index
    end

end
