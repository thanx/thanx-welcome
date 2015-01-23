class MusicJob
  @queue = :thanx_welcome

  def self.perform(params)
    self.new(params).perform
  end

  def initialize(params)
    @params = params.symbolize_keys
  end

  def perform
    song.play if song.present?
  end

private

  def song
    @song ||= songs.offset(rand(songs.count)).first
  end

  def songs
    user.songs
  end

  def user
    @user ||= User.find(@params[:user_id])
  end

end
