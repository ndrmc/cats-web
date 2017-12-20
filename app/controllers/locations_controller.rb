class LocationsController < ApplicationController

  layout 'admin'
  before_action :set_location, only: [ :edit, :update, :destroy]
  before_action :authorize_location
  # GET /locations
  def index
    redirect_to action: :show, id: 0
  end

  # GET /locations/1
  def show
    if params[:id] == '0'
      @locations = Location.where( location_type: :region)

      @listed_locs_type = 'region'
    else
      @parent = Location.find params[:id]
      @locations = @parent.children#.select { |c| !c.deleted }

      @listed_locs_type = child_location_type(@parent.location_type)
    end
  end

  # POST /locations
  def create

    parent_id = params[:parent_id].to_i
    warehouse_id = params[:warehouse]
  
    if params[:name].blank?
      flash[:error] = "The 'name' field is required."

      redirect_to action: :show, id: params[:parent_id]
      return
    end

    begin
      if parent_id == 0
        Location.create!( name: params[:name], location_type: :region )
      else
        parent = Location.find parent_id

        Location.create!( name: params[:name], location_type: child_location_type(parent.location_type), parent: parent, warehouse_id: warehouse_id)
      end

      flash[:success] = 'Created!'

    rescue => e
      Rails.logger.error e.message

      flash[:error] = "Failed! Please try again shortly."
    end

    redirect_to action: :show, id: params[:parent_id]
  end

  # GET /locations/:id/edit
  def edit
  end

  # PATCH/PUT /locations/1
  def update
    @location.transaction do
      @location.update(name: params[:name], warehouse_id: params[:warehouse])
       woreda_locations = Location.find(@location.id).descendants
      woreda_locations.update_all(warehouse_id: params[:warehouse])

      flash[:success] = 'Updated!'
      redirect_to  location_path(@location.parent_id ? @location.parent_id : 0)
      return
    end
    
      flash[:error] = "Couldn't save. Please check your input."
      render :edit
  end

  # DELETE /locations/1
  def destroy
    deleted = @location.destroy

    respond_to do |format|
      format.html {
        if deleted
          flash[:success] = "Deleted!"
        else
          flash[:error] = "Delete failed. Please try again shortly."
        end

        redirect_to  location_path(@location.parent_id ? @location.parent_id : 0)

      }
      format.json { render json:  [ deleted: deleted ].to_json  }
    end

  end

  # GET /locations/1/children
  def children

    if params[:parentId] == '0'
      @children = (Location.where location_type: :region).sort_by{|l| l.name}
    else
      @children = (Location.find(params[:parentId]).children).sort_by{|l| l.name}
    end
    respond_to do |format|
      format.json { render json:  @children.collect { |c| {id: c.id, name: c.name}}.to_json  }
    end
  end

  private

    def authorize_location
        authorize Location
    end

    def set_location
      @location = Location.find params[:id]
    end

    def child_location_type(parent_location_type)
      return Location.location_types.keys[Location.location_types.keys.index(parent_location_type) + 1]
    end



end
