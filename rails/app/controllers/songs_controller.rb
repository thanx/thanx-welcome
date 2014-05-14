class SongsController < ApplicationController
  before_filter :authenticate

  def index
    @songs = []
    @songs = Music::Searcher.search(params[:search]) if params[:search].present?

    @user = User.find(params[:user_id])
    @selections = @user.songs.map{|song| Music::Track.new(song.track_id).summary}
  end

  def create
    user = User.find(params[:user_id])
    case params[:type]
    when 'remove'
      user.songs.where(track_id: params[:track_id]).destroy_all
    when 'add'
      user.songs.create(track_id: params[:track_id])
    end
    redirect_to :back
  end

end
