class TrackingsController < ApplicationController

  before_action except: :deregister do

    @tracking = Tracking.new
    @tracking.build_user
    
    @tracking.assign_attributes tracking_params if params[:tracking]

    @availabilities = Availability.where created_at: (1.week.ago)..(Time.now)

    if params[:tracking]
      @availabilities = @availabilities.where(cat_id: params[:tracking][:cat_id]) if params[:tracking][:cat_id].present?
      @availabilities = @availabilities.where(typ_id: params[:tracking][:typ_id]) if params[:tracking][:typ_id].present?
    end

    @chart_data = @availabilities.group_by_hour(:created_at, range: (1.week.ago)..(Time.now)).count
    @current_availabilities = @availabilities.where.not(expired: true)
  end

  def new; end

  def preview; end

  def create
    @tracking = Tracking.new tracking_params
    @tracking.user.locale = http_accept_language.compatible_language_from I18n.available_locales
    @tracking.save

    if @tracking.valid?
      flash.now[:success] = I18n.t('flash.actions.create.success', resource_name: Tracking.model_name.human)
      TrackingMailer.welcome(@tracking).deliver_later

      @tracking = Tracking.new
      @tracking.build_user
    else
      flash.now[:error] = I18n.t('flash.actions.create.error', resource_name: Tracking.model_name.human)
    end

    respond_to do |format|
      format.js
    end
  end

  def deregister
    @tracking = Tracking.find_by_token params[:id]
    @tracking.deregister!
  end

  protected

    def tracking_params
      params.require(:tracking).permit(:cat_id, :sbcat_id, :typ_id, user_attributes: [:name, :email, :eula])
    end

end