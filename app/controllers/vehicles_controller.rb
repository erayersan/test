class VehiclesController < ApplicationController

  def index
    @vehicles = Vehicle.order(created_at: :desc)
  end

  def show
    set_vehicle
  end

  def new
    @vehicle = Vehicle.new
  end

  def edit
    set_vehicle
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully created.' }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    set_vehicle
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully updated.' }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_vehicle
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: 'Vehicle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end


    def vehicle_params
      params.require(:vehicle).permit(:name, :code, :vehicle_class, :brand, :model, :model_year, :fuel_capacity, :fuel_type, :status, :purchase_date)
    end
end
