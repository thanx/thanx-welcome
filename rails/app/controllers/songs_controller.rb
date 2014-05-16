class SongsController < ApplicationController
  before_filter :authenticate

  def index
    @songs = Music::Searcher.all if params[:search].blank?
    @songs = Music::Searcher.search(params[:search]) if params[:search].present?
    @user = User.find(params[:user_id])
    @selections = @user.songs.map do |song|
      Music::Track.new(song.track_id).summary.merge(
        song_id:  song.id,
        start_at: song.start_at,
        end_at:   song.end_at
      )
    end
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

  def update
    user = User.find(params[:user_id])
    song = user.songs.find_by_id(params[:id]) if user.present?
    song.update_attributes(
      start_at: params[:start_at],
      end_at:   params[:end_at]
    ) if song.present?
    redirect_to :back
  end

end
