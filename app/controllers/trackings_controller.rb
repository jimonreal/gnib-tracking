class TrackingsController < ApplicationController

  respond_to :html

  def new
    @tracking = Tracking.new
    @tracking.build_user
  end

  def create
    @tracking = Tracking.new tracking_params
    success = @tracking.save

    respond_with @tracking
  end

  protected

    def tracking_params
      params.require(:tracking).permit(:cat_id, :sbcat_id, :typ_id, user_attributes: [:email])
    end

end