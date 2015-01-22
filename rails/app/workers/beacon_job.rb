class BeaconJob
  @queue = :thanx_welcome

  def self.perform(params)
    self.new(params).perform
  end

  def initialize(params)
    @params = params.symbolize_keys
  end

  def perform
    Event.create!(
      ibeacon_id:    @params[:beacon_id],
      thanx_user_id: @params[:user_id],
      params:        @params
    )
  end

end
