require 'appscript'

module Music
  class Searcher
    class << self

      #
      # @return [Array]
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

        # @param references [Array]
        # @return [Array<Hash>]
        def convert_references(references)
          references.map{ |reference| Music::Track.new(reference).summary }
        end

        ### Helpers

        def library; @library ||= self.app.playlists['Library'].get end
        def app; @app ||= Appscript.app('iTunes') end

    end
  end
end
