class SongsController < ApplicationController
  def index
    search = params[:search] ? params[:search] : 'song'
    @songs = Music::Searcher.search(search)
  end

  def create
    user = User.find(params[:user_id])
    user.songs.create({track_id: params[:track_id]})
    redirect_to my_songs_user_songs_path(user)
  end

  def my_songs
    user = User.find(params[:user_id])
    @songs = user.songs.map{|song| Music::Track.new(song.track_id).summary}
  end
end
