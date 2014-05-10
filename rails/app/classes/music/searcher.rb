require 'appscript'

module Music
  class Searcher
    class << self

      #
      # @return [Array]
      #   [
      #     {
      #       id:
      #       name:
      #       artist:
      #       album
      #     }
      #   ]
      #
      def search(query)
        tracks = []
        tracks.concat(self.tracks_by_title(query))
        tracks.concat(self.tracks_by_artist(query))
        return tracks
      end

      protected

        #
        #
        #
        def convert_references(references)
          references.map do |reference|
            Music::Track.new(reference.persistent_ID.get).summary
          end
        end

        def tracks_by_artist(artist)
          self.convert_references(
            self.library.tracks[Appscript.its.artist.contains(artist)].get
          )
        end

        def tracks_by_title(title)
          self.convert_references(
            self.library.tracks[Appscript.its.name.contains(title)].get
          )
        end

        ### Helpers

        def library; @library ||= self.app.playlists['Library'].get end
        def app; @app ||= Appscript.app('iTunes') end

    end
  end
end
