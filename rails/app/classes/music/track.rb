require 'appscript'

module Music
  class Track

    #
    # @param track
    #   [NilClass] uses the current track
    #   [String] persistent track id
    #   [Appscript::Reference] track reference
    #
    def initialize(track=nil)
      case track
      when NilClass
        @track_id = self.current_id
      when String
        @track_id = track
      when Appscript::Reference
        @reference = track
        @track_id = track.persistent_ID.get
      end
    end

    def summary
      return {} if self.reference.nil?
      {
        id:       @track_id,
        name:     self.name,
        artist:   self.artist,
        album:    self.album,
        duration: self.duration
      }
    end

    def name; self.reference.name.get.strip end
    def artist; self.reference.artist.get.strip end
    def album; self.reference.album.get.strip end
    def duration; self.reference.duration.get end

    #
    # @return [Appscript::Reference] reference to the track
    #
    def reference
      @reference ||= self.library.tracks[
        Appscript.its.persistent_ID.eq(@track_id)
      ].get[0] rescue nil
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
