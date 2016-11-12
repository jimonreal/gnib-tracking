class TrackingsController < ApplicationController

  before_action do

    @tracking = Tracking.new
    @tracking.build_user

    @availabilities = Availability.where created_at: (1.week.ago)..(1.seconds.ago)

    if params[:tracking]
      @availabilities = @availabilities.where(cat_id: params[:tracking][:cat_id]) if params[:tracking][:cat_id].present?
      @availabilities = @availabilities.where(typ_id: params[:tracking][:typ_id]) if params[:tracking][:typ_id].present?
    end

    @chart_data = @availabilities.group_by_hour(:created_at).count
    @current_availabilities = @availabilities.where.not(expired: true)

  end

  def new; end

  def preview; end

  def create
    @tracking = Tracking.create tracking_params

    if @tracking.valid?
      flash.now[:success] = I18n.t('flash.actions.create.success', resource_name: Tracking.model_name.human)
      @tracking = Tracking.new
      @tracking.build_user    
    else
      flash.now[:error] = I18n.t('flash.actions.create.error', resource_name: Tracking.model_name.human)
    end

    respond_to do |format|
      format.js
    end
  end

  protected

    def tracking_params
      params.require(:tracking).permit(:cat_id, :sbcat_id, :typ_id, user_attributes: [:name, :email, :eula])
    end

end