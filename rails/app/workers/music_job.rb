class MusicJob
  @queue = :thanx_welcome

  def self.perform(params)
    self.new(params).perform
  end

  def initialize(params)
    @params = params.symbolize_keys
  end

  def perform
    case
    when @params.key?(:user_id)
      random_song.try(:play)
    when @params.key?(:song_id)
      song.try(:play)
    end
  end

private

  def random_song
    user.songs.offset(rand(user.songs.count)).first
  end

  def user
    User.find_by(id: @params[:user_id])
  end

  def song
    Song.find_by(id: @params[:song_id])
  end

end
