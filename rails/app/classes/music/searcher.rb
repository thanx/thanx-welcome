require 'appscript'

module Music

  SONG_LIMIT = 50

  class Searcher
    class << self

      #
      # @return [Array] all tracks in the iTunes library
      #   [
      #     {
      #       id:       String, # persistent track id
      #       name:     String, # track name
      #       artist:   String, # artist name
      #       album:    String, # album name
      #       duration: Float   # track duration in seconds
      #     }
      #   ]
      #
      def all
        self.convert_references(self.library.tracks.get)
      end

      #
      # @param query [String] search query
      #
      # @return [Array] search results
      #
      #   [
      #     {
      #       id:       String, # persistent track id
      #       name:     String, # track name
      #       artist:   String, # artist name
      #       album:    String, # album name
      #       duration: Float   # track duration in seconds
      #     }
      #   ]
      #
      def search(query)
        references = self.library.tracks[
          # search by artst
          Appscript.its.artist.contains(query).or(
            # or by song name
            Appscript.its.name.contains(query)
          )
        ].get
        self.convert_references(references)
      end

      protected

        #
        # @param references [Array] array of track references
        #
        # @return [Array<Hash>] summary of tracks
        #
        def convert_references(references)
          tracks = []
          references.each_with_index do |reference, index|
            break if index >= Music::SONG_LIMIT
            tracks << Music::Track.new(reference).summary
          end
          return tracks
        end

        ### Helpers

        def library; @library ||= self.app.playlists['Library'].get end
        def app; @app ||= Appscript.app('iTunes') end

    end
  end
end
