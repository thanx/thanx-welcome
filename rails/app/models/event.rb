class Event < ActiveRecord::Base
  attr_accessor :thanx_user_id

  belongs_to :user

  after_create :play_song

  def thanx_user_id=(thanx_user_id)
    @thanx_user_id = thanx_user_id
    self.user = User.find_by(thanx_id: thanx_user_id)
  end

protected

  def play_song
    Resque.enqueue(MusicJob, user_id: self.user_id) if no_events_today?
  end

  def no_events_today?
    self.user.events.where(
      'created_at >= ? AND created_at < ?',
      Time.current.beginning_of_day, self.created_at
    ).blank?
  end

end
