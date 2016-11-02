class TrackingsController < ApplicationController

  respond_to :html

  def new
    @tracking = Tracking.new
    @tracking.build_user
  end

  def avaibility_chart
    availabilities = Availability.where created_at: (1.week.ago)..(1.seconds.ago)

    if params[:tracking]
      availabilities = availabilities.where(cat_id: params[:tracking][:cat_id]) if params[:tracking][:cat_id].present?
      availabilities = availabilities.where(sbcat_id: params[:tracking][:sbcat_id]) if params[:tracking][:sbcat_id].present?
      availabilities = availabilities.where(typ_id: params[:tracking][:typ_id]) if params[:tracking][:typ_id].present?
    end

    render json: availabilities.group_by_hour(:created_at).count
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