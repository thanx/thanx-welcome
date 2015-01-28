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
      random_song.play
    when @params.key(:song_id)
      song.play
    end
  end

private

  def random_song
    user.songs.offset(rand(songs.count)).first
  end

  def user
    User.find_by(id: @params[:user_id])
  end

  def song
    Song.find_by(id: @params[:song_id])
  end

end
