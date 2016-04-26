class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy, :claim]

  def claim
    if current_user
      current_user.cars << @car
      redirect_to root_path,
        notice: "#{@car.make} #{@car.model} has been moved to your inventory."
    else
      redirect_to root_path,
        notice: 'You must be logged in to claim a car'
    end
  end

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.where(user_id: nil)
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  def my_cars
    @cars = Car.where(user_id: current_user)
    render :index
  end

  # GET /cars/new
  def new
    @car = Car.new
    authorize(@car)
  end

  # GET /cars/1/edit
  def edit
    authorize(@car)
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to root_path, notice: "#{@car.year} #{@car.make} #{@car.model} created" }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to root_path, notice: "#{@car.year} #{@car.make} #{@car.model} updated" }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    authorize(@car)
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:make, :model, :year, :price)
    end
end
