module Music
  class Player
    class << self

      ### Player State

      # Play or unpause iTunes. Optionally accepts a given track
      # @param track [String] track id
      def play(track=nil); self.app.play(Music::Track.new(track).reference) end
      # Pause the current track
      def pause; self.app.pause end
      # Stop the current track
      def stop; self.app.stop end
      # @return [Symbol] current player state
      #   :paused
      #   :playing
      #   :stopped
      def state; self.app.player_state.get end

      ### Current Track
      def track(track)
        self.app.current_track.set(Music::Track.new(track).reference)
      end

      ### Player Position

      # @return [Integer]
      def position; self.app.player_position.get end
      # Sets the current position in the track
      # @param position [Float] play position in seconds
      def position=(position); self.app.player_position.set(position) end

      ### Player Volume

      # @return [Integer] current player volume
      def volume; self.app.sound_volume.get end
      # @param volume [Integer] volume to set the player to
      def volume=(volume); self.app.sound_volume.set(volume) end

      protected

        # @return [Appscript::Application] reference to the iTunes app
        def app; @app ||= Appscript.app('iTunes') end

    end
  end
end
