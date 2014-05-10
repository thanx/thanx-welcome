require 'appscript'

module Music
  class Track

    def initialize(track_id=nil)
      @track_id = track_id.nil? ? self.current_id : track_id
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

    def name; self.reference.name.get end
    def artist; self.reference.artist.get end
    def album; self.reference.album.get end
    def duration; self.reference.duration.get end

    #
    # @return [Appscript::Reference] reference to the track
    #
    def reference
      self.library.tracks[
        Appscript.its.persistent_ID.eq(@track_id)
      ].get[0]
    end

    protected

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
