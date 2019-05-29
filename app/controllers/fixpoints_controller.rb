class FixpointsController < ApplicationController
  skip_before_action :authenticate_user!

  before_action :set_fixpoint, only: [:show, :edit, :update]

  def index
    #@fixpoints = Fixpoint.all

    @fixpoints = Fixpoint.where.not(latitude: nil, longitude: nil)

    @markers = @fixpoints.map do |fixpoint|
      {
        lat: fixpoint.latitude,
        lng: fixpoint.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { fixpoint: fixpoint })
      }
    end
  end

  def show
  end

  def new
    @fixpoint = Fixpoint.new
  end

  def create
    @fixpoint = Fixpoint.new(fixpoint_params)

    if @fixpoint.save
      redirect_to @fixpoint
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @fixpoint.update(fixpoint_params)
      redirect_to @fixpoint
    else
      render :edit
    end
  end

  private

  def set_fixpoint
    @fixpoint = Fixpoint.find(params[:id])
  end

  def fixpoint_params
    params.require(:fixpoint).permit(:longitude, :latitude, :fix_date, :fixed)
  end
end
