module Music
  class Track

    def initialize(track_id=nil)
      @track_id = self.current_id if track_id.nil?
    end

    def summary
      {
        id:       @track_id,
        name:     self.name,
        artist:   self.artist,
        album:    self.album,
        duration: self.duration
      }
    end

    def name; self.track.name.get end
    def artist; self.track.artist.get end
    def album; self.track.album.get end
    def duration; self.track.duration.get end

    protected

      #
      # @return [Appscript::Reference] reference to the track
      #
      def track
        @track ||= self.library.tracks[
          Appscript.its.persistent_ID.eq(@track_id)
        ].get[0]
      end

      #
      # @return [String, NilClass] id of current track
      #
      def current_id
        self.app.current_track.persistent_ID.get rescue nil
      end

      ### Helpers

      def library; @library ||= self.app.playlists['Library'].get end
      def app; @app ||= Appscript.app('iTunes') end

  end
end
